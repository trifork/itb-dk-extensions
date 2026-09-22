import {test, expect} from '@playwright/test';
import {readFileSync} from 'node:fs';
import {stripTypeScriptTypes} from 'node:module';
import {createHash} from 'node:crypto';
import {execFileSync} from 'node:child_process';

const source = stripTypeScriptTypes(readFileSync(new URL('../cda-preview.ts', import.meta.url), 'utf8'))
  .replace("'__CDA_PREVIEW_URL__'", "'http://itb.test/render'");
const pageHtml = `<button id="start">View CDA</button><script type="module">
import {showCdaPreview,isXmlAttachment} from '/extension.js';
window.isXmlAttachment=isXmlAttachment;
window.preview=bytes=>showCdaPreview(async()=>new Blob([new Uint8Array(bytes)],{type:'application/xml'}));
window.ready=true;
</script>`;

test.beforeEach(async ({page}) => {
  await page.route('http://itb.test/', route => route.fulfill({contentType: 'text/html', body: pageHtml}));
  await page.route('http://itb.test/extension.js', route => route.fulfill({contentType: 'text/javascript', body: source}));
  await page.goto('http://itb.test/');
  await page.waitForFunction(() => window.ready);
});

async function open(page, bytes = [...Buffer.from('<ClinicalDocument xmlns="urn:hl7-org:v3"/>')]) {
  await page.evaluate(bytes => { void window.preview(bytes); }, bytes);
}

test('identifies XML attachments without offering HTML or PDF rendering', async ({page}) => {
  expect(await page.evaluate(() => [
    window.isXmlAttachment('text/xml; charset=utf-8'),
    window.isXmlAttachment('application/hl7-v3+xml'),
    window.isXmlAttachment(undefined, 'xml'),
    window.isXmlAttachment(undefined, 'document.xml'),
    window.isXmlAttachment('text/html', 'document.html'),
    window.isXmlAttachment('application/pdf', 'document.pdf')
  ])).toEqual([true,true,true,true,false,false]);
});

test('preserves original bytes and isolates rendered output from the report', async ({page}) => {
  const bytes = [...Buffer.from('\ufeff<ClinicalDocument xmlns="urn:hl7-org:v3"><title>æøå</title></ClinicalDocument>', 'utf16le')];
  let posted;
  await page.route('http://itb.test/render', async route => {
    posted = [...route.request().postDataBuffer()];
    await route.fulfill({contentType: 'text/html;charset=UTF-8', body: '<h1>Document narrative</h1><script>parent.document.body.dataset.compromised="true"</script>'});
  });
  await open(page, bytes);
  await expect(page.frameLocator('iframe').getByRole('heading')).toHaveText('Document narrative');
  expect(posted).toEqual(bytes);
  await expect(page.locator('iframe')).toHaveAttribute('sandbox', '');
  await expect(page.locator('iframe')).toHaveAttribute('referrerpolicy', 'no-referrer');
  await expect(page.locator('body')).not.toHaveAttribute('data-compromised', 'true');
  await expect(page.getByText('This preview does not establish conformance', {exact:false})).toBeVisible();
  await page.getByRole('button', {name:'Close preview'}).click();
  await expect(page.getByRole('dialog')).toHaveCount(0);
});

for (const [status, message] of [
  [400, 'Preview requires a CDA ClinicalDocument in the urn:hl7-org:v3 namespace.'],
  [400, 'The XML could not be parsed at line 1, column 1.'],
  [400, 'Preview does not accept DOCTYPE declarations.'],
  [422, 'The display stylesheet could not render this document.'],
  [429, 'Preview is busy. Please try again shortly.']
]) {
  test(`reports preview failure safely: ${message}`, async ({page}) => {
    await page.route('http://itb.test/render', route => route.fulfill({status,contentType:'text/plain',body:message}));
    await open(page);
    await expect(page.getByRole('status')).toHaveText(message);
    await expect(page.locator('iframe')).toBeHidden();
  });
}

test('rejects oversized attachments before sending them', async ({page}) => {
  let requests=0;
  await page.route('http://itb.test/render', route => { requests++; return route.abort(); });
  await page.evaluate(() => { void window.preview(new Array(10*1024*1024+1).fill(32)); });
  await expect(page.getByRole('status')).toContainText('up to 10 MiB');
  expect(requests).toBe(0);
});

test('closing a pending preview prevents stale content appearing', async ({page}) => {
  let pending;
  await page.route('http://itb.test/render', route => { pending=route; });
  await open(page);
  await expect.poll(() => !!pending).toBe(true);
  await page.getByRole('button',{name:'Close preview'}).click();
  await pending.fulfill({contentType:'text/html',body:'<h1>Stale</h1>'}).catch(() => {});
  await expect(page.getByRole('dialog')).toHaveCount(0);
  await expect(page.locator('iframe')).toHaveCount(0);
});

test('renders a CDA that fails conformance using the deployed validator', async ({page, request}) => {
  test.setTimeout(70000);
  const base=process.env.CDA_PREVIEW_TEST_URL;
  test.skip(!base, 'Set CDA_PREVIEW_TEST_URL to exercise the deployed CDA renderer');
  await page.route('http://itb.test/render', async route => {
    const result=await request.post(base,{data:route.request().postDataBuffer(),headers:{'Content-Type':'application/xml'}});
    await route.fulfill({status:result.status(),contentType:result.headers()['content-type'],body:await result.body()});
  });
  await open(page,[...Buffer.from('<ClinicalDocument xmlns="urn:hl7-org:v3"><title>Preview despite validation errors</title></ClinicalDocument>')]);
  await expect(page.frameLocator('iframe').getByRole('heading', {name:'Preview despite validation errors'})).toBeVisible({timeout: 60000});
});

test('gateway serves the image frontend with source provenance and boots ITB', async ({page, request}) => {
  const base = process.env.ITB_PREVIEW_TEST_URL;
  test.skip(!base, 'Set ITB_PREVIEW_TEST_URL to exercise the deployed frontend');
  const upstream = JSON.parse(readFileSync(new URL('../upstream.json', import.meta.url), 'utf8'));
  const provenanceResponse = await request.get(`${base}/itb-extension/provenance.json`);
  expect(provenanceResponse.ok()).toBe(true);
  const provenance = await provenanceResponse.json();
  expect(provenance.upstream).toEqual(upstream);
  const compose = JSON.parse(execFileSync('docker', ['compose', 'config', '--format', 'json'], {cwd: new URL('../../', import.meta.url)}));
  expect(provenance.upstream.image).toBe(compose.services['gitb-ui'].image);
  const hash = bytes => createHash('sha256').update(bytes).digest('hex');
  for (const [name, digest] of Object.entries(provenance.inputs)) {
    expect(hash(readFileSync(new URL(`../${name}`, import.meta.url)))).toBe(digest);
  }
  for (const [name, type] of [['main.js', /javascript/], ['styles.css', /text\/css/]]) {
    const response = await request.get(`${base}/assets/build/${name}?v=${upstream.version}`);
    expect(response.ok()).toBe(true);
    expect(response.headers()['content-type']).toMatch(type);
    expect(response.headers()['cache-control']).toBe('no-cache');
    expect(hash(await response.body())).toBe(provenance.files[name]);
  }
  await page.goto(`${base}/app`);
  await expect(page.locator('app-root')).not.toBeEmpty();
});

for (const [label, xml, expected, status] of [
  ['CDA despite validation errors', '<ClinicalDocument xmlns="urn:hl7-org:v3"><title>Preview despite validation errors</title></ClinicalDocument>', 'Preview despite validation errors', 200],
  ['non-CDA XML', '<document/>', 'ClinicalDocument', 400],
  ['DOCTYPE', '<!DOCTYPE ClinicalDocument><ClinicalDocument xmlns="urn:hl7-org:v3"/>', 'DOCTYPE', 400],
]) {
  test(`ITB origin and security policy: ${label}`, async ({page, request}) => {
    test.setTimeout(70000);
    const base = process.env.ITB_PREVIEW_TEST_URL;
    test.skip(!base, 'Set ITB_PREVIEW_TEST_URL to exercise the real same-origin gateway');
    const origin = new URL(base).origin;
    const app = await request.get(`${origin}/app`);
    expect(app.ok()).toBe(true);
    const policy = app.headers()['content-security-policy'];
    expect(policy).toContain("connect-src 'self';");
    expect(policy).toContain("frame-src 'self';");
    expect(policy).toContain("frame-ancestors 'none';");
    // Only the fixture page and its scripts are intercepted. The browser's real
    // POST crosses the gateway, with ITB's actual CSP and no CORS bypass.
    await page.route(`${origin}/__cda-preview-test`, route => route.fulfill({
      contentType: 'text/html', headers: {'Content-Security-Policy': policy},
      body: '<button id="start">View CDA</button><script type="module" src="/__cda-preview-test.js"></script>'
    }));
    await page.route(`${origin}/__cda-preview-extension.js`, route => route.fulfill({
      contentType: 'text/javascript', body: source.replace('http://itb.test/render', '/cda-preview')
    }));
    await page.route(`${origin}/__cda-preview-test.js`, route => route.fulfill({
      contentType: 'text/javascript',
      body: `import {showCdaPreview} from '/__cda-preview-extension.js';
        document.querySelector('#start').onclick=()=>showCdaPreview(async()=>new Blob([${JSON.stringify(xml)}],{type:'application/xml'}));`
    }));
    await page.goto(`${origin}/__cda-preview-test`);
    const response = page.waitForResponse(`${origin}/cda-preview`);
    await page.getByRole('button', {name: 'View CDA', exact: true}).click();
    expect((await response).status()).toBe(status);
    if (status === 200) {
      await expect(page.frameLocator('iframe').getByRole('heading', {name: expected})).toBeVisible({timeout: 60000});
    } else {
      await expect(page.getByRole('status')).toContainText(expected);
      await expect(page.locator('iframe')).toBeHidden();
    }
    await page.getByRole('button', {name: 'Close preview'}).click();
    await expect(page.getByRole('dialog')).toHaveCount(0);
  });
}
