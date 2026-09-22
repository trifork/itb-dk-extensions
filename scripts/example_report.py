#!/usr/bin/env python3
"""Render the actual validator findings for every catalogue example as Markdown."""
import argparse
from collections import defaultdict
from datetime import datetime, timezone
import hashlib
import json
import os
from pathlib import Path
from urllib.parse import quote

ROOT = Path(__file__).resolve().parents[1]


def result_name(sample):
    return hashlib.sha256((sample['validationType'] + ':' + sample['file']).encode()).hexdigest() + '.json'


def resource_hash(directory):
    digest = hashlib.sha256()
    for path in sorted(directory.rglob('*')):
        if path.is_file():
            digest.update(path.relative_to(directory).as_posix().encode() + b'\0')
            digest.update(hashlib.sha256(path.read_bytes()).digest())
    return digest.hexdigest()


def save_result(sample, report, directory):
    findings = []
    for item in report.findall('{*}reports/*'):
        severity = item.tag.rsplit('}', 1)[-1]
        if severity in ('error', 'warning'):
            findings.append(dict(severity=severity, rule=item.findtext('{*}assertionID') or '',
                                 message=item.findtext('{*}description') or '',
                                 location=item.findtext('{*}location') or '',
                                 test=item.findtext('{*}test') or ''))
    result = dict(file=sample['file'], validationType=sample['validationType'],
                  validatedAt=datetime.now(timezone.utc).isoformat(),
                  resourceSha256=os.environ.get('VALIDATOR_RESOURCE_SHA256'),
                  sha256=hashlib.sha256((ROOT / sample['file']).read_bytes()).hexdigest(),
                  result=report.findtext('{*}result'),
                  errors=int(report.findtext('{*}counters/{*}nrOfErrors')),
                  warnings=int(report.findtext('{*}counters/{*}nrOfWarnings')), findings=findings)
    directory = Path(directory)
    directory.mkdir(parents=True, exist_ok=True)
    (directory / result_name(sample)).write_text(json.dumps(result, indent=2, ensure_ascii=False) + '\n')


def cell(value):
    return ' '.join(str(value).split()).replace('|', '\\|').replace('<', '&lt;').replace('>', '&gt;')


def render(directory, output):
    samples = json.loads((ROOT / 'samples/validation-cases.json').read_text())
    catalogue = {r['id']: r for r in json.loads((ROOT / 'cda-validator/domain/cda-dk/rulesets.json').read_text())['rulesets']}
    inventory = {}
    for folder in ('pro-conformance', 'cda-conformance'):
        for rule in json.loads((ROOT / 'docs' / folder / 'rules.json').read_text()):
            inventory[rule['id']] = rule
    def link(path):
        return quote(os.path.relpath(ROOT / path, output.parent), safe='/.-_')
    results = []
    missing = []
    for sample in samples:
        file = directory / result_name(sample)
        if not file.exists():
            missing.append(sample)
            continue
        result = json.loads(file.read_text())
        assert result['file'] == sample['file'] and result['validationType'] == sample['validationType']
        assert result['sha256'] == hashlib.sha256((ROOT / sample['file']).read_bytes()).hexdigest(), sample['file']
        results.append((sample, result))
    fingerprints = {r.get('resourceSha256') for _, r in results}
    assert len(fingerprints) <= 1, 'Results mix different deployed rule bundles; rerun the full Docker test'
    groups = defaultdict(list)
    for sample, result in results:
        groups[sample['validationType']].append((sample, result))
    lines = ['# MedCom CDA example validation report', '',
             'This report records actual XSD, Schematron and Gazelle results from the pinned XML validator image. '
             'Official XML bytes are unchanged. File hashes and source URLs are recorded in the '
             f'[example catalogue]({link("samples/validation-cases.json")}).', '',
             '**Interpretation:** FAILURE means the example has reported validation errors; it does not mean the '
             'regression test failed. SUCCESS means no errors were found by the implemented checks. Coverage is partial. '
             'Counts are findings, not independent specification clauses or a percentage of conformance: inherited '
             'validators may report the same underlying defect more than once.', '',
             f'See [coverage and specification conflicts]({link("docs/cda-conformance.md")}) and '
             f'[QRD/QFDD coverage]({link("docs/pro-conformance.md")}). Ambiguous clauses that are deliberately not '
             'enforced are coverage gaps, not silent evidence of conformity.', '',
             f'Examples executed: **{len(results)} / {len(samples)}**. '
             f'Official source URLs indexed: **{len({u for s in samples for u in s.get("publishedSources", [s["source"]] if "source" in s else [])})}**. '
             'Identical published bytes can share one validation result. Archived APD examples without a supported '
             'original release are explicitly labelled as migration comparisons below.', '',
             '| Profile | Examples | No errors | With errors | Errors | Warnings |',
             '| --- | ---: | ---: | ---: | ---: | ---: |']
    for target, rows in sorted(groups.items()):
        lines.append('| ' + catalogue[target]['label'] + ' | ' + ' | '.join(map(str, [len(rows),
                     sum(r['errors'] == 0 for _, r in rows), sum(r['errors'] > 0 for _, r in rows),
                     sum(r['errors'] for _, r in rows), sum(r['warnings'] for _, r in rows)])) + ' |')
    if results:
        timestamps = [r['validatedAt'] for _, r in results if r.get('validatedAt')]
        if timestamps:
            lines.extend(['', f'Run interval (UTC): {min(timestamps)} to {max(timestamps)}.'])
        if fingerprints != {None}:
            lines.extend(['', 'Deployed resource bundle SHA-256: `' + next(iter(fingerprints)) + '`.'])
    image = directory.parent / 'image.txt'
    if image.exists():
        lines.extend(['', '```text', image.read_text().strip(), '```'])
    if missing:
        lines.extend(['', '## Not executed', ''])
        lines.extend('- ' + s['file'] + ' — ' + s['validationType'] for s in missing)
    for target, rows in sorted(groups.items()):
        lines.extend(['', '## ' + catalogue[target]['label'], '',
                      f'[Specification]({catalogue[target]["source"]})', '',
                      '| Example | Result | Errors | Warnings | Distinct error rules |',
                      '| --- | --- | ---: | ---: | ---: |'])
        for sample, result in rows:
            lines.append(f'| [{cell(Path(sample["file"]).name)}]({link(sample["file"])}) | {result["result"]} | '
                         f'{result["errors"]} | {result["warnings"]} | '
                         f'{len({f["rule"] or f["message"] for f in result["findings"] if f["severity"] == "error"})} |')
        for sample, result in rows:
            lines.extend(['', '### ' + cell(Path(sample['file']).name), ''])
            if sample.get('comparisonNote'):
                lines.extend(['**Comparison limitation:** ' + sample['comparisonNote'], ''])
            sources = sample.get('publishedSources', [sample['source']] if 'source' in sample else [])
            if sources:
                lines.extend(['Published at: ' + ', '.join(f'[MedCom source {i+1}]({u})' for i, u in enumerate(sources)) + '.', ''])
            if not result['findings']:
                lines.append('No errors or warnings from the implemented checks.')
                continue
            findings = defaultdict(list)
            for finding in result['findings']:
                findings[(finding['severity'], finding['rule'], finding['message'])].append(finding['location'])
            lines.extend(['| Severity | Rule / specification | Count | Finding | Example location |',
                          '| --- | --- | ---: | --- | --- |'])
            for (severity, identifier, message), locations in sorted(findings.items()):
                rule = inventory.get(identifier)
                label = cell(identifier) or '(validator diagnostic)'
                if rule:
                    label = f'[{label}]({rule["source"]})'
                if target.startswith('pdc.') and "[@root = '1.2.208.176'][@extension = 'NI']" in message:
                    message = ('KNOWN INHERITED-RULE CONFLICT: this legacy check expects the old placeholder '
                               'identifier; the guide/errata requires the SOR identifier. ' + message)
                lines.append(f'| {severity} | {label} | {len(locations)} | {cell(message)} | {cell(locations[0])} |')
    output.parent.mkdir(parents=True, exist_ok=True)
    output.write_text('\n'.join(lines) + '\n')
    print(f'Wrote {output}: {len(results)} executed, {len(missing)} missing')
    return not missing


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--results', type=Path, default=ROOT / 'test-results/example-results')
    parser.add_argument('--output', type=Path, default=ROOT / 'docs/example-validation-report.md')
    parser.add_argument('--fingerprint', type=Path, help='Hash a staged resource directory instead of rendering')
    args = parser.parse_args()
    if args.fingerprint:
        print(resource_hash(args.fingerprint))
    else:
        raise SystemExit(0 if render(args.results, args.output.resolve()) else 1)
