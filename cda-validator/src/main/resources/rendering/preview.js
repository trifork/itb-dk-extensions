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
        'Structured questionnaire fields may not be shown. This preview does not establish conformance.</p>' +
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
