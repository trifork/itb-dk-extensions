import {readFileSync, writeFileSync} from 'node:fs';
import {join} from 'node:path';

const root = process.argv[2];
const component = join(root, 'src/app/components/diagram/report/any-content-view/any-content-view.component.ts');
const template = component.replace(/\.ts$/, '.html');
function replaceOnce(path, before, after) {
  const text = readFileSync(path, 'utf8');
  if (text.split(before).length !== 2) throw new Error(`Unsupported upstream report viewer: ${path}`);
  writeFileSync(path, text.replace(before, () => after));
}

replaceOnce(component, 'import {Component, Input, OnInit}', `import {firstValueFrom} from 'rxjs';
import {isXmlAttachment, showCdaPreview} from './cda-preview';

import {Component, Input, OnInit}`);
replaceOnce(component, '  downloadPending = false', '  previewPending = false\n  downloadPending = false');
replaceOnce(component, '  private toBlob(mimeType: string) {', `  canPreviewCda(): boolean {
    return !this.withItems && isXmlAttachment(this.context.mimeType, this.context.name);
  }

  async previewCda(): Promise<void> {
    this.previewPending = true;
    try {
      await showCdaPreview(async () => {
        if (this.isFileReference(this.context) && this.sessionId) {
          const data = await firstValueFrom(this.downloadFileReference(this.sessionId, this.context, false));
          if (!data.dataAsBytes) throw new Error('The original XML could not be loaded from this report.');
          return new Blob([data.dataAsBytes], {type: 'application/xml'});
        }
        return this.toBlob('application/xml');
      });
    } finally {
      this.previewPending = false;
    }
  }

  private toBlob(mimeType: string) {`);
replaceOnce(template, '<div class="btn-toolbar">', `<div class="btn-toolbar">
                                @if (canPreviewCda()) {
                                    <button class="btn btn-secondary me-1" type="button" (click)="previewCda()"
                                            [disabled]="previewPending" aria-label="View CDA"
                                            title="Render the CDA header and narrative">View CDA</button>
                                }`);
const source = readFileSync(new URL('./cda-preview.ts', import.meta.url), 'utf8')
  .replace("'__CDA_PREVIEW_URL__'", "'/cda-preview'");
writeFileSync(join(root, 'src/app/components/diagram/report/any-content-view/cda-preview.ts'), source);
