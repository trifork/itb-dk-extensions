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

const reportTemplate = join(root, 'src/app/components/tar-report/tar-report.component.html');
replaceOnce(reportTemplate, '            @if (reportsToShow.length > 0) {', `            @if (selectable && ((showErrors && errors > 0) || (showWarnings && warnings > 0))) {
                <p class="text-muted mb-2">Click an error or warning for more details.</p>
            }
            @if (reportsToShow.length > 0) {`);

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

// Interaction forms can be much taller than the viewport. Keep their header and
// actions fixed and scroll only the fields; avoid competing open/close animations.
for (const [path, before] of [
  ['src/app/pages/test-execution/test-execution.component.ts', "this.modalService.open(ProvideInputModalComponent, { size: 'lg'})"],
  ['src/app/components/session-table/session-table.component.ts', "this.modalService.open(ProvideInputModalComponent, { size: 'lg' })"],
]) {
  replaceOnce(join(root, path), before,
    "this.modalService.open(ProvideInputModalComponent, { size: 'lg', scrollable: true, animation: false })");
}
const interaction = join(root, 'src/app/modals/provide-input-modal/provide-input-modal.component');
replaceOnce(interaction + '.html', 'style="overflow-x: auto; overflow-y: hidden;"', 'style="overflow-x: auto;"');
const interactionStyles = readFileSync(interaction + '.less', 'utf8');
writeFileSync(interaction + '.less', interactionStyles + `
:host {
  display: flex;
  flex-direction: column;
  min-height: 0;
  max-height: calc(100dvh - 3.5rem);
}
form {
  display: flex;
  flex-direction: column;
  min-height: 0;
  overflow: hidden;
}
.provide-input-body { overflow-y: auto; }
.modal-header, .modal-footer { flex-shrink: 0; }
`);
const interactionCode = readFileSync(interaction + '.ts', 'utf8');
const focusCall = "this.dataService.focus('input-'+this.firstTextIndex)";
if (interactionCode.split(focusCall).length !== 3) throw new Error('Unsupported upstream interaction focus');
writeFileSync(interaction + '.ts', interactionCode.replaceAll(focusCall,
  "document.getElementById('input-'+this.firstTextIndex)?.focus({preventScroll: true})"));

// Keep a failed session and its diagnostics on screen. A batch may continue
// automatically after success, but failure/stop requires an explicit next test.
const execution = join(root, 'src/app/pages/test-execution/test-execution.component');
replaceOnce(execution + '.ts', '  startAutomatically = true',
  '  startAutomatically = true\n  nextTestPending = false');
replaceOnce(execution + '.ts', '  private initialiseState() {',
  '  private initialiseState() {\n    this.nextTestPending = false');
replaceOnce(execution + '.ts', '  stopAll() {',
  '  stopAll() {\n    this.nextTestPending = false');
replaceOnce(execution + '.ts', `      timer(1000).subscribe(() => {
        this.prepareNextTest(this.startAutomatically)
      })`, `      this.started = false
      this.nextWaitingToStart = false
      this.nextTestPending = true
      if (this.startAutomatically && this.testCaseStatus[this.currentTest!.id] == Constants.TEST_CASE_STATUS.COMPLETED) {
        const finishedSession = this.session
        timer(1000).subscribe(() => {
          if (this.session == finishedSession && this.startAutomatically) this.startNextTest()
        })
      }`);
replaceOnce(execution + '.ts', '  setPendingStepsToSkipped() {', `  startNextTest() {
    if (this.nextTestPending && !this.allStopped) {
      this.nextTestPending = false
      this.prepareNextTest(true)
    }
  }

  setPendingStepsToSkipped() {`);
replaceOnce(execution + '.html',
  '                        <button type="button" [labelIcon]="Constants.BUTTON_ICON.PLAY" class="btn btn-primary" [disable]="!nextWaitingToStart" (click)="start(session!)">Start</button>',
  `                        @if (nextTestPending) {
                            <button type="button" [labelIcon]="Constants.BUTTON_ICON.PLAY" class="btn btn-primary" (click)="startNextTest()">Start next test</button>
                        } @else {
                            <button type="button" [labelIcon]="Constants.BUTTON_ICON.PLAY" class="btn btn-primary" [disable]="!nextWaitingToStart" (click)="start(session!)">Start</button>
                        }`);
