import {test, expect} from '@playwright/test';
import {execFileSync} from 'node:child_process';
import {fileURLToPath} from 'node:url';

const root = fileURLToPath(new URL('../../', import.meta.url));
const base = process.env.ITB_PREVIEW_TEST_URL;
function state(path) {
  // Parse saved shell quoting as data, without sourcing secrets into a shell.
  return JSON.parse(execFileSync('python3', ['-c', `import json,shlex,sys
from pathlib import Path
print(json.dumps({k:' '.join(shlex.split(v)) for line in Path(sys.argv[1]).read_text().splitlines() if '=' in line for k,v in [line.split('=',1)]}))`, path]));
}

for (const stamkort of [false, true]) {
  test(`guided ${stamkort ? 'Stamkort' : 'DDS'} search keeps controls visible and submits the selected values`, async ({page, request}) => {
    test.skip(!base, 'Set ITB_PREVIEW_TEST_URL to test the deployed synthetic ITB stack');
    test.setTimeout(180000);
    const saved = state(process.env.ITB_STATE_FILE || root + 'get-up-and-running/.itb-bootstrap.env');
    const users = state(process.env.ITB_USER_STATE_FILE || root + 'get-up-and-running/.itb-users.env');
    const headers = {ITB_API_KEY: saved.ITB_ORGANISATION_API_KEY};
    const started = await request.post(`${base}/api/rest/tests/start`, {headers, data: {
      system: saved.ITB_SYSTEM_API_KEY, actor: saved.ITB_ACTOR_API_KEY,
      testCase: [saved.ITB_INTERACTIVE_TEST_CASE_API_KEY], waitForCompletion: false,
    }});
    expect(started.ok()).toBeTruthy();
    const session = (await started.json()).createdSessions[0].session;
    try {
      await page.goto(`${base}/app#/login`);
      await page.locator('#username').fill(users.ITB_TEST_USERNAME);
      await page.locator('#password').fill(users.ITB_TEST_PASSWORD);
      await page.getByRole('button', {name: /Log in/}).click();
      const sessionsLink = page.locator('a[href*="/organisation/tests/"]');
      await expect(sessionsLink).toBeAttached();
      const path = await sessionsLink.getAttribute('href');
      await page.goto(`${base}/app${path}?session=${session}`);
      const dialog = page.getByRole('dialog');
      async function openPending(title) {
        await expect(async () => {
          await page.reload();
          await page.getByRole('button', {name: /View pending interaction/}).click({timeout: 2000});
        }).toPass({timeout: 30000, intervals: [1000]});
        await expect(dialog.locator('.modal-title')).toHaveText(title);
      }
      async function submit() {
        const response = page.waitForResponse(res => /\/provide(admin)?$/.test(new URL(res.url()).pathname));
        await dialog.getByRole('button', {name: /Submit/}).click();
        const sent = await response;
        expect(sent.ok()).toBeTruthy();
        await expect(dialog).toHaveCount(0);
      }
      await openPending('Document source');
      await dialog.getByLabel('Document source').selectOption({label: 'IHE XDS (DDS) retrieval'});
      await submit();
      await openPending('Choose XDS registry');
      await dialog.getByLabel('Registry', {exact: false}).selectOption({label: stamkort ? 'Synthetic Stamkort' : 'Synthetic registry One'});
      await submit();
      await openPending(stamkort ? 'Find Stamkort in SFSK' : 'Find in XDS');
      // Covers the large first search form at the default 720px test viewport.
      const geometry = await dialog.evaluate(element => ({
        titleTop: element.querySelector('.modal-title').getBoundingClientRect().top,
        footerBottom: element.querySelector('.modal-footer').getBoundingClientRect().bottom,
        viewport: window.innerHeight,
        windowScroll: window.scrollY,
        outerScroll: element.scrollTop,
      }));
      expect(geometry.titleTop).toBeGreaterThanOrEqual(0);
      expect(geometry.footerBottom).toBeLessThanOrEqual(geometry.viewport);
      expect(geometry.outerScroll).toBe(0);
      const patientField = dialog.getByLabel('Test CPR (10 digits)', {exact: false});
      await patientField.fill('2512489996');
      if (stamkort) {
        await expect(dialog.locator('input,select')).toHaveCount(3);
        await expect(dialog.getByLabel('Signing identity', {exact: false}).locator('option:checked')).toContainText('System fixture');
        await expect(dialog.getByLabel('Stamkort version (optional)').locator('option:checked')).toHaveText('Any');
      } else {
        const identity = dialog.getByLabel('Signing identity', {exact: false});
        const label = await identity.locator('option').allTextContents();
        await identity.selectOption({label: label.find(value => value.includes('Synthetic test professional'))});
        const entryField = dialog.getByLabel('Document entry type (multiple allowed)', {exact: false});
        await expect(entryField.locator('option:checked')).toHaveCount(2);
        await dialog.getByLabel('Type code (multiple allowed)').selectOption({label: 'Any'});
        await dialog.getByLabel('Format code (multiple allowed)').selectOption({label: 'Any'});
      }
      const submitted = page.waitForRequest(req => /\/provide(admin)?$/.test(new URL(req.url()).pathname));
      await submit();
      const input = JSON.parse(new URLSearchParams((await submitted).postData()).get('inputs'));
      expect(input[0].value).toBe('2512489996');
      if (!stamkort) expect(input[2].value).toBe('Stable (stored document),On-demand (generated on retrieval)');
      await openPending('XDS documents');
      const actions = dialog.getByLabel('Next step', {exact: false});
      await actions.selectOption({label: (await actions.locator('option').allTextContents()).find(value => value.startsWith('View documents and choose one'))});
      await submit();
      await openPending('Select XDS document');
      const documents = dialog.getByLabel('Document', {exact: false});
      await documents.selectOption({label: (await documents.locator('option').allTextContents()).find(value => value.includes('phmr-2.1.0'))});
      await submit();
      await openPending('PHMR-DK 2.1.0 validation completed');
      const finalised = page.waitForResponse(res => /\/provide(admin)?$/.test(new URL(res.url()).pathname));
      await dialog.getByRole('button', {name: /Close/}).click();
      expect((await finalised).ok()).toBeTruthy();
      await expect.poll(async () => {
        const response = await request.post(`${base}/api/rest/tests/status`, {headers, data: {session: [session], withLogs: false, withReports: false}});
        return (await response.json()).sessions[0].result;
      }, {timeout: 60000}).toBe('SUCCESS');
    } finally {
      const auth = await request.post(`${base}/api/oauth/access_token`, {form: {email: users.ITB_ADMIN_USERNAME, password: users.ITB_ADMIN_PASSWORD}});
      const token = (await auth.json()).access_token;
      await request.post(`${base}/api/tests/${session}/stop`, {headers: {Authorization: `Bearer ${token}`}, form: {}});
    }
  });
}

test('failed batch search stays visible until Start next test is chosen', async ({page, request}) => {
  test.skip(!base, 'Set ITB_PREVIEW_TEST_URL to test the deployed ITB stack');
  test.setTimeout(90000);
  const saved = state(process.env.ITB_STATE_FILE || root + 'get-up-and-running/.itb-bootstrap.env');
  const users = state(process.env.ITB_USER_STATE_FILE || root + 'get-up-and-running/.itb-users.env');
  const sessions = [];
  const initiated = response => response.request().method() === 'POST' && /\/initiate$/.test(new URL(response.url()).pathname);
  page.on('response', async response => {
    if (initiated(response)) sessions.push((await response.json()).value);
  });
  try {
    await page.goto(`${base}/app#/login`);
    await page.locator('#username').fill(users.ITB_TEST_USERNAME);
    await page.locator('#password').fill(users.ITB_TEST_PASSWORD);
    await page.getByRole('button', {name: /Log in/}).click();
    const statements = page.locator('a[href*="/organisation/conformance/"]');
    await expect(statements).toBeAttached();
    await statements.click();
    const statement = page.locator('a[href*="/actor/"]');
    await expect(statement).toBeAttached();
    await page.goto(`${base}/app${await statement.getAttribute('href')}`);
    await page.locator('.testSuiteControls button.btn-primary').click();
    await expect(page.getByRole('button', {name: /Start$/})).toBeEnabled();
    await page.getByRole('button', {name: /Start$/}).click();
    const dialog = page.getByRole('dialog');
    await expect(dialog.locator('.modal-title')).toHaveText('Document source');
    await dialog.getByLabel('Document source').selectOption({label: 'IHE XDS (DDS) retrieval'});
    await dialog.getByRole('button', {name: /Submit/}).click();
    await expect(dialog.locator('.modal-title')).toHaveText('Choose XDS registry');
    const registry = dialog.getByLabel('Registry', {exact: false});
    const label = (await registry.locator('option').allTextContents()).find(value => value.includes('Stamkort'));
    await registry.selectOption({label});
    await dialog.getByRole('button', {name: /Submit/}).click();
    await expect(dialog.locator('.modal-title')).toHaveText('Find Stamkort in SFSK');
    // This fails local input validation before any call to NSP, even on a live bench.
    await dialog.getByLabel('Test CPR (10 digits)', {exact: false}).fill('invalid');
    await dialog.getByRole('button', {name: /Submit/}).click();
    await expect(page.getByRole('button', {name: /Start next test/})).toBeVisible();
    await expect(dialog).toHaveCount(0);
    await expect(page.locator('.test-case-container').first()).toBeVisible();
    const headers = {ITB_API_KEY: saved.ITB_ORGANISATION_API_KEY};
    await expect.poll(async () => {
      const response = await request.post(`${base}/api/rest/tests/status`, {headers, data: {session: [sessions[0]], withLogs: false, withReports: false}});
      return (await response.json()).sessions[0].result;
    }).toBe('FAILURE');
    // Upstream used a one-second timer to create/start the next session and hide this failure.
    const advanced = await page.waitForResponse(initiated, {timeout: 2500}).then(() => true, () => false);
    expect(advanced).toBe(false);
    expect(sessions).toHaveLength(1);
    await page.getByRole('button', {name: /Start next test/}).click();
    await expect(dialog.locator('.modal-title')).toHaveText('Document source');
    expect(sessions).toHaveLength(2);
    expect(sessions[1]).not.toBe(sessions[0]);
  } finally {
    const auth = await request.post(`${base}/api/oauth/access_token`, {form: {email: users.ITB_ADMIN_USERNAME, password: users.ITB_ADMIN_PASSWORD}});
    const token = (await auth.json()).access_token;
    for (const session of sessions) {
      await request.post(`${base}/api/tests/${session}/stop`, {headers: {Authorization: `Bearer ${token}`}, form: {}});
    }
  }
});
