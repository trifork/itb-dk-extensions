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

// TDL has no date/time input type. Explicit MIME parameters opt only marked text
// requests into UTC pickers while keeping the stock engine's string contract.
replaceOnce(interaction + '.html', '<form (ngSubmit)="submit()">',
  '<form #interactionForm (ngSubmit)="submit(interactionForm)">');
replaceOnce(interaction + '.html', '<!-- Text field -->', `<!-- Text field -->
  @if (isUtcDateTime(interaction)) {
    <label class="form-label d-block" [attr.for]="'precision-'+index">Precision</label>
    <select class="form-select mb-2" [attr.aria-label]="interaction.desc + ' — precision'" [id]="'precision-'+index" [name]="'precision-'+index"
      [ngModel]="utcPrecision(interaction)" (ngModelChange)="setUtcPrecision(interaction, $event)">
      <option value="year">Year</option><option value="month">Month</option>
      <option value="day">Day</option><option value="hour">Hour</option>
      <option value="minute">Minute</option><option value="second">Second</option>
    </select>
  }`);
replaceOnce(interaction + '.html', 'type="text" class="form-control" [(ngModel)]="interaction.data"',
  `[type]="utcInputType(interaction)" [attr.step]="utcStep(interaction)"
   [attr.pattern]="isUtcDateTime(interaction) && utcPrecision(interaction) == 'year' ? '[1-9][0-9]{3}' : null"
   [attr.placeholder]="isUtcDateTime(interaction) && utcPrecision(interaction) == 'year' ? 'YYYY' : null"
   class="form-control" [(ngModel)]="interaction.data"`);
replaceOnce(join(root, 'src/app/types/user-interaction.ts'), '  mimeType?: string;',
  '  mimeType?: string;\n  utcDatePrecision?: string;');
replaceOnce(interaction + '.ts', '  submit() {', `  isUtcDateTime(interaction: UserInteraction): boolean {
    return interaction.inputType == 'TEXT' && interaction.mimeType == 'text/plain;format=date-time;timezone=UTC'
  }

  utcPrecision(interaction: UserInteraction): string {
    return interaction.utcDatePrecision ?? 'second'
  }

  setUtcPrecision(interaction: UserInteraction, precision: string) {
    interaction.utcDatePrecision = precision
    // Changing precision must not silently invent or discard a selected boundary.
    interaction.data = ''
  }

  utcInputType(interaction: UserInteraction): string {
    if (!this.isUtcDateTime(interaction)) return 'text'
    switch (this.utcPrecision(interaction)) {
      case 'year': return 'text'
      case 'month': return 'month'
      case 'day': return 'date'
      default: return 'datetime-local'
    }
  }

  utcStep(interaction: UserInteraction): number | null {
    if (!this.isUtcDateTime(interaction)) return null
    switch (this.utcPrecision(interaction)) {
      case 'hour': return 3600
      case 'minute': return 60
      default: return 1
    }
  }

  submit(form?: HTMLFormElement) {
    // Angular disables native form submission checks. Incomplete dates must not
    // become empty optional bounds; year format and hour/minute steps matter too.
    if (form && !form.reportValidity()) return`);
replaceOnce(interaction + '.ts', '        const hasValue = ', `        if (this.isUtcDateTime(interaction) && inputData.value) {
          // Keep UTC wall-clock fields and their chosen precision. No local-zone
          // conversion or padding of partial bounds: ITI-18 defines comparison.
          const precision = this.utcPrecision(interaction)
          if (precision == 'hour') inputData.value = inputData.value.slice(0, 13)
          else if (precision == 'minute') inputData.value = inputData.value.slice(0, 16)
          else if (precision == 'second') inputData.value += inputData.value.length == 16 ? ':00Z' : 'Z'
        }
        const hasValue = `);
