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

// A large document repeats the same finding at many places. Show one card per
// distinct finding (severity, assertion ID, description, test) and list each
// location as a link that opens the original XML at that line, as a single card does.
// Counts in the summary stay per finding; no finding is dropped or reworded.
const reportDir = join(root, 'src/app/components/tar-report/tar-report.component');
replaceOnce(reportDir + '.html', `                @for (assertionReport of reportsToShow; track assertionReport.trackingId) {
                    <app-test-assertion-report (click)="selectedItem(assertionReport)" [assertionReport]="assertionReport"></app-test-assertion-report>
                }`, `                @for (group of groups; track group.key) {
                    @if (group.occurrences.length == 1) {
                        <app-test-assertion-report (click)="selectedItem(group.occurrences[0].report)" [assertionReport]="group.occurrences[0].report"></app-test-assertion-report>
                    } @else {
                        <div class="cda-group" [ngClass]="group.type">
                            <div class="cda-group-content">
                                <div class="cda-group-title">
                                    <span class="cda-group-icon"><i class="fa-solid" [ngClass]="{'fa-info-circle': group.type == 'info', 'fa-warning': group.type == 'warning', 'fa-times-circle': group.type == 'error'}"></i></span>{{group.description}}
                                    <span class="cda-group-count">{{group.occurrences.length}} occurrences</span>
                                </div>
                                @if (group.assertionID != undefined) {
                                    <div class="cda-group-meta"><span class="cda-group-key">Assertion ID:</span> {{group.assertionID}}</div>
                                }
                                @if (group.test != undefined) {
                                    <div class="cda-group-meta"><span class="cda-group-key">Test:</span> {{group.test}}</div>
                                }
                                <button type="button" class="btn btn-link btn-sm cda-group-toggle" (click)="toggleGroup(group)"
                                        [attr.aria-expanded]="isGroupOpen(group)">
                                    {{isGroupOpen(group) ? 'Hide' : 'Show'}} {{group.occurrences.length}} locations
                                </button>
                                @if (isGroupOpen(group)) {
                                    <ul class="cda-group-locations">
                                        @for (occurrence of group.occurrences; track occurrence.report.trackingId) {
                                            <li>
                                                @if (occurrence.report.extractedLocation != undefined) {
                                                    <a href="#" role="button" (click)="openOccurrence($event, occurrence.report)">{{occurrence.label}}</a>
                                                } @else {
                                                    <span>{{occurrence.label}}</span>
                                                }
                                                @if (occurrence.detail != undefined) {
                                                    <span class="cda-group-detail"> {{occurrence.detail}}</span>
                                                }
                                            </li>
                                        }
                                    </ul>
                                }
                            </div>
                        </div>
                    }
                }`);
replaceOnce(reportDir + '.ts', '  reportsToShow: AssertionReport[] = []\n', `  reportsToShow: AssertionReport[] = []
  groups: FindingGroup[] = []
  private openGroups = new Set<string>()

  private groupReports() {
    const byKey = new Map<string, FindingGroup>()
    for (const report of this.reportsToShow) {
      const key = JSON.stringify([report.type, report.value?.assertionID, report.value?.description, report.value?.test])
      let group = byKey.get(key)
      if (!group) {
        group = {key, type: report.type, assertionID: report.value?.assertionID,
          description: report.value?.description, test: report.value?.test, occurrences: []}
        byKey.set(key, group)
      }
      group.occurrences.push(this.occurrence(report))
    }
    this.groups = Array.from(byKey.values())
  }

  // Same location syntax as the single-finding card: "name:line:column|details".
  private occurrence(report: AssertionReport): FindingOccurrence {
    const location = report.value?.location
    const separator = location ? location.indexOf('|') : -1
    const position = location ? (separator < 0 ? location : location.substring(0, separator)) : undefined
    const matches = position ? /^([\\w\\.]+):([\\-0-9]+):([\\-0-9]+)$/.exec(position) : null
    const detail = separator >= 0 && separator < location!.length - 1 ? location!.substring(separator + 1) : undefined
    if (matches) {
      report.extractedLocation = {type: 'line-column-number', name: matches[1], line: Number(matches[2]), column: Number(matches[3])}
    }
    const label = matches ? 'Line ' + matches[2] + (Number(matches[3]) > 0 ? ', column ' + matches[3] : '') : (location ?? 'Location not reported')
    const value = report.value?.value
    return {report, label, detail: value != undefined ? (detail ? detail + ' — ' + value : value) : detail}
  }

  toggleGroup(group: FindingGroup) {
    if (!this.openGroups.delete(group.key)) this.openGroups.add(group.key)
  }

  isGroupOpen(group: FindingGroup): boolean {
    return this.openGroups.has(group.key)
  }

  openOccurrence(event: Event, report: AssertionReport) {
    event.preventDefault()
    this.selectedItem(report)
  }
`);
replaceOnce(reportDir + '.ts', '    this.reportsToShow = this.reports\n  }', '    this.reportsToShow = this.reports\n    this.groupReports()\n  }');
replaceOnce(reportDir + '.ts', "        || (report.type == 'warning' && this.showWarnings)\n    })\n  }",
  "        || (report.type == 'warning' && this.showWarnings)\n    })\n    this.groupReports()\n  }");
const reportSource = readFileSync(reportDir + '.ts', 'utf8');
writeFileSync(reportDir + '.ts', reportSource + `
interface FindingOccurrence {
  report: AssertionReport
  label: string
  detail?: string
}

interface FindingGroup {
  key: string
  type: 'info'|'warning'|'error'
  assertionID?: string
  description?: string
  test?: string
  occurrences: FindingOccurrence[]
}
`);
writeFileSync(reportDir + '.less', readFileSync(reportDir + '.less', 'utf8') + `
.cda-group {
    border-radius: 4px;
    .cda-group-content { margin-left: 4px; padding: 5px; border-radius: 0 4px 4px 0; }
    .cda-group-icon { margin-right: 5px; }
    .cda-group-count { margin-left: 8px; font-size: 0.85em; font-weight: bold; opacity: 0.8; }
    .cda-group-meta { margin-top: 10px; }
    .cda-group-key { display: inline-block; margin-right: 6px; font-weight: bold; }
    .cda-group-toggle { padding-left: 0; color: inherit; text-decoration: underline; }
    .cda-group-locations { margin: 4px 0 0; padding-left: 20px; max-height: 320px; overflow-y: auto; }
    .cda-group-locations a { color: inherit; font-weight: bold; text-decoration: underline; }
    .cda-group-detail { word-break: break-word; }
    &.error { background: @red-error-border; border: 1px solid @red-error-border;
        .cda-group-content { background: @red-error-background; color: @red-error-text; }
        .cda-group-icon { color: @red-error-content; } }
    &.warning { background: @orange-warning-border; border: 1px solid @orange-warning-border;
        .cda-group-content { background: @orange-warning-background; color: @orange-warning-text; }
        .cda-group-icon { color: @orange-warning-content; } }
    &.info { background: @blue-info-border; border: 1px solid @blue-info-border;
        .cda-group-content { background: @blue-info-background; color: @blue-info-text; }
        .cda-group-icon { color: @blue-info-content; } }
}
`);

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
