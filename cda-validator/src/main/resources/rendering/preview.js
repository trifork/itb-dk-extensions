/* CDA display extension for the pinned ITB upload form. Validation keeps the original input. */
(() => {
    'use strict';
    const submit = document.getElementById('inputFileSubmit');
    if (!submit || document.getElementById('cda-preview-button')) return;
    const button = document.createElement('button');
    button.id = 'cda-preview-button';
    button.type = 'button';
    button.className = 'btn btn-default';
    button.style.marginLeft = '8px';
    button.textContent = 'View CDA';
    submit.after(button);

    const panel = document.createElement('section');
    panel.id = 'cda-preview-panel';
    panel.hidden = true;
    panel.className = 'panel panel-default';
    panel.innerHTML = '<div class="panel-heading"><strong>CDA document preview</strong>' +
        '<button type="button" class="btn btn-default btn-xs pull-right">Close preview</button></div>' +
        '<div class="panel-body"><p>Shows the CDA header and narrative using the shared display stylesheet. ' +
        'The structured entries of the document are also listed after the narrative: questions and answers for a questionnaire, otherwise its observations, groups, encounters and other acts. This preview does not establish conformance.</p>' +
        '<p role="status" aria-live="polite"></p>' +
        '<iframe title="CDA document preview" sandbox="" referrerpolicy="no-referrer" ' +
        'style="width:100%;height:70vh;border:1px solid #ddd;background:white" hidden></iframe></div>';
    submit.closest('form').after(panel);
    const status = panel.querySelector('[role="status"]');
    const frame = panel.querySelector('iframe');
    let revision = 0;
    let request;
    function clear() {
        revision++;
        if (request) request.abort();
        frame.removeAttribute('srcdoc');
        frame.hidden = true;
        panel.hidden = true;
        button.disabled = false;
    }
    panel.querySelector('button').addEventListener('click', clear);
    document.getElementById('inputFile').addEventListener('change', clear);
    document.getElementById('contentType').addEventListener('change', clear);
    const editor = document.querySelector('#stringToValidate .CodeMirror')?.CodeMirror;
    if (editor) editor.on('change', clear);
    button.addEventListener('click', async () => {
        clear();
        const current = revision;
        panel.hidden = false;
        status.textContent = 'Rendering document…';
        button.disabled = true;
        request = new AbortController();
        try {
            const mode = document.getElementById('contentType').value;
            let body;
            if (mode === 'fileType') {
                body = document.getElementById('inputFile').files[0];
                if (!body) throw new Error('Choose a CDA XML file first.');
            } else if (mode === 'stringType') {
                body = new Blob([editor ? editor.getValue() : document.getElementById('text-editor').value]);
                if (!body.size) throw new Error('Paste CDA XML first.');
            } else {
                throw new Error('To preview, choose File or Direct input and supply the CDA XML.');
            }
            if (body.size > 10 * 1024 * 1024) throw new Error('Preview supports CDA documents up to 10 MiB.');
            const response = await fetch('preview', {
                method: 'POST', headers: {'Content-Type': 'application/xml'}, body,
                cache: 'no-store', signal: request.signal
            });
            const html = await response.text();
            if (current !== revision) return;
            if (!response.ok) throw new Error(response.status === 400 || response.status === 413 || response.status === 422 || response.status === 429
                ? html : 'The preview service could not render this document. Please try again.');
            frame.srcdoc = html;
            frame.hidden = false;
            status.textContent = 'Preview of ' + (body.name || 'the pasted CDA XML') + '.';
        } catch (error) {
            if (current === revision) status.textContent = error.message;
        } finally {
            if (current === revision) button.disabled = false;
        }
    });
})();

/*
 * Findings that repeat at many places are shown as one card in the detailed report. The original
 * report items are moved into the card, not copied, so the upstream page keeps working: clicking a
 * location runs its own handler (annotated input at that line), the severity filter still applies
 * and the findings and counts are unchanged. Only the display is grouped.
 */
(() => {
    'use strict';
    const SEVERITIES = ['report-item-error', 'report-item-warning', 'report-item-info'];
    const text = (element, selector) => (element.querySelector(selector)?.textContent ?? '').replace(/\s+/g, ' ').trim();

    function location(item) {
        const raw = text(item, '.item-info-location');
        const parts = raw.split('|')[0].split(':');
        if (parts.length !== 3 || isNaN(parts[1]) || isNaN(parts[2])) return raw || 'Location not reported';
        return 'Line ' + parseInt(parts[1], 10) + (parseInt(parts[2], 10) > 0 ? ', column ' + parseInt(parts[2], 10) : '');
    }

    function key(item) {
        const severity = SEVERITIES.find(name => item.classList.contains(name)) ?? '';
        const tests = Array.from(item.querySelectorAll('.report-item-test')).map(row => row.textContent.replace(/\s+/g, ' ').trim());
        return JSON.stringify([severity, text(item, '.item-info-text'), tests]);
    }

    function compact(item, label) {
        for (const part of item.querySelectorAll('.item-info-text, .report-item-test, .report-item-icon')) part.style.display = 'none';
        const link = document.createElement('span');
        link.className = 'cda-group-location';
        link.textContent = label;
        link.style.cssText = 'text-decoration:underline;font-weight:bold;cursor:pointer';
        item.append(link);
        item.setAttribute('role', 'button');
        item.tabIndex = 0;
        for (const [name, value] of [['background', 'transparent'], ['border', '0'], ['margin', '0'], ['padding', '2px 0'], ['box-shadow', 'none']]) {
            item.style.setProperty(name, value, 'important');
        }
        const inner = item.querySelector('.report-item-div');
        if (inner) inner.style.setProperty('padding', '0', 'important');
        item.addEventListener('keydown', event => {
            if (event.key === 'Enter' || event.key === ' ') {
                event.preventDefault();
                if (typeof window.setCode === 'function') window.setCode(item);
            }
        });
    }

    function card(items) {
        const first = items[0];
        const wrapper = document.createElement('div');
        wrapper.className = 'row report-item cda-group ' + (SEVERITIES.find(name => first.classList.contains(name)) ?? '');
        const body = document.createElement('div');
        body.className = 'report-item-div container-fluid';
        const head = document.createElement('div');
        head.className = 'col-xs-12 cda-group-head';
        const icon = first.querySelector('.report-item-icon');
        if (icon) head.append(icon.cloneNode(true), ' ');
        const title = document.createElement('span');
        title.textContent = text(first, '.item-info-text');
        const count = document.createElement('strong');
        count.style.marginLeft = '8px';
        count.textContent = items.length + ' occurrences';
        head.append(title, count);
        body.append(head);
        for (const row of first.querySelectorAll('.report-item-test')) body.append(row.cloneNode(true));
        const toggle = document.createElement('button');
        toggle.type = 'button';
        toggle.className = 'btn btn-link btn-xs';
        toggle.style.cssText = 'padding-left:0;color:inherit;text-decoration:underline';
        const list = document.createElement('div');
        list.className = 'col-xs-12 cda-group-locations';
        list.style.cssText = 'max-height:320px;overflow-y:auto;padding-top:4px';
        list.hidden = true;
        const sync = () => {
            toggle.textContent = (list.hidden ? 'Show ' : 'Hide ') + items.length + ' locations';
            toggle.setAttribute('aria-expanded', String(!list.hidden));
        };
        toggle.addEventListener('click', () => { list.hidden = !list.hidden; sync(); });
        sync();
        const toggleRow = document.createElement('div');
        toggleRow.className = 'col-xs-12';
        toggleRow.append(toggle);
        body.append(toggleRow, list);
        wrapper.append(body);
        for (const item of items) {
            compact(item, location(item));
            list.append(item);
        }
        return wrapper;
    }

    function group() {
        const container = document.getElementById('reportItemsDetailed');
        if (!container) return;
        const groups = new Map();
        for (const item of container.querySelectorAll('.report-item')) {
            if (item.closest('.cda-group') || !item.querySelector('.item-info-text')) continue;
            const id = key(item);
            if (!groups.has(id)) groups.set(id, []);
            groups.get(id).push(item);
        }
        for (const items of groups.values()) {
            if (items.length < 2) continue;
            // The card takes the first occurrence's place; the rest are moved into it.
            const marker = document.createComment('');
            items[0].before(marker);
            marker.replaceWith(card(items));
        }
    }

    let scheduled = false;
    new MutationObserver(() => {
        if (scheduled) return;
        scheduled = true;
        setTimeout(() => { scheduled = false; group(); }, 50);
    }).observe(document.body, {childList: true, subtree: true});
    group();
})();
