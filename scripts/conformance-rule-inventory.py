#!/usr/bin/env python3
"""Regenerate/check the reviewable rule inventory from the maintained Schematrons."""
import argparse
import json
from pathlib import Path
import xml.etree.ElementTree as ET

ROOT = Path(__file__).resolve().parents[1]
NS = {'sch': 'http://purl.oclc.org/dsdl/schematron'}


def inventory(pro):
    rows = []
    ids = set()
    for path in sorted((ROOT / 'cda-validator/domain/cda-dk/sch/versions').glob('*-conformance.sch')):
        if path.name.startswith(('qrd-', 'qfdd-')) != pro:
            continue
        schema = ET.parse(path)
        for pattern in schema.findall('sch:pattern', NS):
            for rule in pattern.findall('sch:rule', NS):
                for assertion in rule.findall('sch:assert', NS):
                    identifier = assertion.attrib['id']
                    assert identifier not in ids, identifier
                    ids.add(identifier)
                    assert assertion.attrib.get('see', '').startswith('https://svn.medcom.dk/'), identifier
                    rows.append(dict(id=identifier, file=str(path.relative_to(ROOT)),
                                     context=rule.attrib['context'], test=assertion.attrib['test'],
                                     severity=assertion.attrib['flag'], source=assertion.attrib['see'],
                                     message=' '.join(''.join(assertion.itertext()).split())))
    return rows


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--check', action='store_true')
    args = parser.parse_args()
    for pro, folder in [(True, 'pro-conformance'), (False, 'cda-conformance')]:
        rows = inventory(pro)
        result = json.dumps(rows, indent=2) + '\n'
        output = ROOT / 'docs' / folder / 'rules.json'
        if args.check:
            assert output.read_text() == result, 'Run python3 scripts/conformance-rule-inventory.py'
        else:
            output.parent.mkdir(parents=True, exist_ok=True)
            output.write_text(result)
        print(f'Verified {len(rows)} source-traced {folder} assertions')
