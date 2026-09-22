#!/usr/bin/env python3
"""Render Maven JUnit reports and preserved CDA example findings for CI."""
import argparse
from collections import Counter
import hashlib
import html
import json
import os
from pathlib import Path
import xml.etree.ElementTree as ET

ROOT = Path(__file__).resolve().parents[2]
STATUS = {'passed': '✅ Passed', 'failed': '❌ Failed', 'not_run': '⏭️ Not run',
          'success': '✅ Passed', 'failure': '❌ Failed', 'skipped': '⏭️ Not run',
          'cancelled': '⚠️ Cancelled'}


def cell(value):
    return html.escape(str(value)).replace('|', '&#124;').replace('\n', '<br>')


def outcome(value):
    if value is None:
        return '—'
    return f"{value['result']} · {value['errors']} errors · {value['warnings']} warnings"


def java_tests(directory, component='Java plugin'):
    rows = []
    for path in sorted(directory.glob('TEST-*.xml')):
        for test in ET.parse(path).iter('testcase'):
            failure = test.find('failure')
            if failure is None:
                failure = test.find('error')
            rows.append(dict(name=test.get('name', ''), classname=test.get('classname', ''), target=component,
                             status='failed' if failure is not None else 'not_run' if test.find('skipped') is not None else 'passed',
                             error='' if failure is None else failure.get('message', '') or failure.text or 'Test failed'))
    return rows


def render(directory, java_directory, artifact_url='', steps=None, integration_directory=None):
    integration_directory = integration_directory or java_directory.parent / 'failsafe-reports'
    integration = java_tests(integration_directory, 'Deployed validator')
    unit_rows = java_tests(java_directory)
    sample_rows = []
    matched_names = set()
    for sample in json.loads((ROOT / 'samples/validation-cases.json').read_text()):
        identity = f"{sample['file']} [{sample['validationType']}]"
        matches = [row for row in integration if row['classname'].endswith('.CdaSamplesIT')
                   and (row['name'] == identity or row['name'].endswith(' ' + identity)
                        or row['name'].endswith(f'[{identity}]'))]
        row = dict(name=sample['file'], target=sample['validationType'], expected=sample['expected'], status='not_run')
        if matches:
            matched_names.update(match['name'] for match in matches)
            row.update(status=matches[0]['status'], error=matches[0]['error'])
            name = hashlib.sha256((sample['validationType'] + ':' + sample['file']).encode()).hexdigest() + '.json'
            result = directory / 'example-results' / name
            if result.exists():
                row['actual'] = json.loads(result.read_text())
        sample_rows.append(row)
    version_rows = [r for r in integration if r['classname'].endswith('.CdaVersionsIT')]
    location_rows = [r for r in integration if r['classname'].endswith('.CdaLocationsIT')]
    # Include initialization/fork errors even when no parameterized sample name exists.
    other_rows = [r for r in integration if r not in version_rows + location_rows and r['name'] not in matched_names]
    rows = sample_rows + version_rows + location_rows + other_rows + unit_rows
    counts = Counter(row['status'] for row in rows)
    lines = ['## CDA validator test report', '',
             f"**✅ {counts['passed']} passed · ❌ {counts['failed']} failed · ⏭️ {counts['not_run']} not run**", '',
             'A test passes when observed behavior matches its expectation. Invalid sample documents are expected to return `FAILURE`.', '',
             'Maven Surefire reports unit tests; Failsafe reports checks against the running validator. Missing reports do not count as passes.', '']
    image = directory / 'image.txt'
    if image.exists():
        lines += ['<details><summary>Tested Docker image</summary>', '', '<pre>' + html.escape(image.read_text()) + '</pre>', '</details>', '']
    else:
        lines += ['The Docker image was not started or its metadata was not captured.', '']
    if steps:
        lines += ['### Pipeline stages', '', '| Stage | Outcome |', '| --- | --- |']
        for name, status in steps.items():
            lines.append(f'| {cell(name)} | {STATUS.get(status, "⏭️ Not run")} |')
        lines += ['']
    if (directory / 'example-validation-report.md').exists():
        lines += ['The artifact contains **example-validation-report.md** with every example’s findings and specification references.', '']
    lines += ['### Sample documents', '', '| Test | Release | Expected | Observed | Outcome |', '| --- | --- | --- | --- | --- |']
    for row in sample_rows:
        lines.append('| ' + ' | '.join(map(cell, [row['name'].removeprefix('samples/'), row['target'], outcome(row['expected']), outcome(row.get('actual')), STATUS[row['status']]])) + ' |')
    for title, group in [('Version and validation checks', version_rows), ('Error-location checks', location_rows), ('Integration initialization / other checks', other_rows), ('Java unit tests', unit_rows)]:
        lines += ['', '### ' + title, '']
        if not group:
            lines += ['No test report was produced. See the pipeline stages above.']
            continue
        lines += ['| Check | Release / component | Outcome |', '| --- | --- | --- |']
        for row in group:
            lines.append('| ' + ' | '.join(map(cell, [row['name'], row['target'], STATUS[row['status']]])) + ' |')
    for row in rows:
        if row.get('error'):
            lines += ['', '<details><summary>' + cell(row['name']) + '</summary>', '', '<pre>' + html.escape(row['error'][:6000]) + '</pre>', '</details>']
    state = directory / 'container-state.json'
    if state.exists():
        data = json.loads(state.read_text())
        if not data.get('Running'):
            lines += ['', f"**Container stopped:** exit code {data.get('ExitCode')}; OOM killed: {data.get('OOMKilled')}."]
    lines += ['', '### Full diagnostics', '', f'[Download validation reports and logs]({artifact_url})' if artifact_url else 'See the `cda-validation-results` artifact for Maven XML reports, example findings and container logs.', '',
              'These tests verify implemented checks; they do not establish complete MedCom specification coverage.', '']
    return '\n'.join(lines)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--results', type=Path, default=ROOT / 'test-results')
    parser.add_argument('--java-reports', type=Path, default=ROOT / 'cda-validator/target/surefire-reports')
    parser.add_argument('--integration-reports', type=Path, default=ROOT / 'cda-validator/target/failsafe-reports')
    parser.add_argument('--output', type=Path)
    args = parser.parse_args()
    steps = {label: os.environ.get(variable, '') for label, variable in [
        ('Configuration and reporting checks', 'CHECKS_OUTCOME'), ('Build and unit tests', 'BUILD_OUTCOME'),
        ('Pinned Sonar analyzer installation', 'SONAR_INSTALL_OUTCOME'),
        ('Sonar Java / symbolic execution', 'SONAR_OUTCOME'), ('Docker integration tests', 'DOCKER_OUTCOME')]}
    report = render(args.results, args.java_reports, os.environ.get('ARTIFACT_URL', ''), steps, args.integration_reports)
    destination = args.output or (Path(os.environ['GITHUB_STEP_SUMMARY']) if os.environ.get('GITHUB_STEP_SUMMARY') else None)
    if destination:
        destination.write_text(report)
    else:
        print(report)


if __name__ == '__main__':
    main()
