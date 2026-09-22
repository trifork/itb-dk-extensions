/** CDA report preview. Original report bytes and validation findings are never changed. */
const MAX_BYTES = 10 * 1024 * 1024;
const PREVIEW_URL = '__CDA_PREVIEW_URL__';

export function isXmlAttachment(mimeType?: string, name?: string): boolean {
  const mime = (mimeType ?? '').split(';')[0].trim().toLowerCase();
  return mime === 'application/xml' || mime === 'text/xml' || mime.endsWith('+xml')
    || (name ?? '').toLowerCase() === 'xml' || (name ?? '').toLowerCase().endsWith('.xml');
}

export async function showCdaPreview(load: () => Promise<Blob>): Promise<void> {
  const dialog = document.createElement('dialog');
  dialog.setAttribute('aria-label', 'CDA document preview');
  dialog.style.cssText = 'width:min(1200px,95vw);max-width:95vw;height:90vh;border:1px solid #aaa;border-radius:8px;padding:20px;';
  const heading = document.createElement('div');
  heading.style.cssText = 'display:flex;justify-content:space-between;align-items:center;margin-bottom:12px';
  const title = document.createElement('h2');
  title.textContent = 'CDA document preview';
  title.style.margin = '0';
  const close = document.createElement('button');
  close.type = 'button';
  close.className = 'btn btn-secondary';
  close.textContent = 'Close preview';
  heading.append(title, close);
  const description = document.createElement('p');
  description.textContent = 'Shows the CDA header and narrative. Structured questionnaire fields may not be shown. This preview does not establish conformance or change the validation result.';
  const status = document.createElement('p');
  status.setAttribute('role', 'status');
  status.textContent = 'Preparing preview…';
  const frame = document.createElement('iframe');
  frame.title = 'Rendered CDA document';
  frame.setAttribute('sandbox', '');
  frame.referrerPolicy = 'no-referrer';
  frame.style.cssText = 'width:100%;height:calc(100% - 120px);border:1px solid #ddd;background:white';
  frame.hidden = true;
  dialog.append(heading, description, status, frame);
  const abort = new AbortController();
  const timeout = setTimeout(() => abort.abort(), 60000);
  const dismiss = () => dialog.close();
  close.addEventListener('click', dismiss);
  dialog.addEventListener('close', () => {
    abort.abort();
    clearTimeout(timeout);
    frame.removeAttribute('srcdoc');
    dialog.remove();
  }, {once: true});
  document.body.append(dialog);
  dialog.showModal();
  try {
    const xml = await load();
    if (abort.signal.aborted) return;
    if (xml.size > MAX_BYTES) throw new Error('Preview supports CDA documents up to 10 MiB.');
    // The shared renderer checks well-formedness, CDA namespace/root and DOCTYPE restrictions.
    // Send original bytes, retaining declared XML encodings such as ISO-8859-1 and UTF-16.
    const response = await fetch(PREVIEW_URL, {
      method: 'POST', headers: {'Content-Type': 'application/xml'},
      body: xml, credentials: 'omit', cache: 'no-store', signal: abort.signal,
      redirect: 'error', referrerPolicy: 'no-referrer'
    });
    const contentType = response.headers.get('Content-Type') ?? '';
    if (!response.ok) {
      const message = contentType.startsWith('text/plain') ? await response.text() : '';
      throw new Error(message || 'The CDA preview service could not render this document.');
    }
    if (!contentType.startsWith('text/html')) throw new Error('The preview service returned an unexpected response.');
    const html = await response.text();
    if (!dialog.isConnected) return;
    frame.srcdoc = html;
    frame.hidden = false;
    status.hidden = true;
  } catch (error) {
    if (dialog.isConnected) {
      status.className = 'alert alert-warning';
      status.textContent = error instanceof Error && error.name !== 'TypeError' && error.name !== 'AbortError'
        ? error.message : 'The preview service is unavailable or timed out. You can still view or download the XML.';
    }
  } finally {
    clearTimeout(timeout);
  }
}
