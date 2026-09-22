#!/usr/bin/env python3
"""Map deployed testcase order to durable, release-specific session slots."""
import json
from pathlib import Path
import re
import xml.etree.ElementTree as ET

ROOT = Path(__file__).resolve().parents[1]
TDL = '{http://www.gitb.com/tdl/v1/}'


def sessions(root=ROOT):
    rulesets = {r['id']: r for r in json.loads((root/'cda-validator/domain/cda-dk/rulesets.json').read_text())['rulesets']}
    suite_dir = root/'get-up-and-running/test-suite'
    suite = ET.parse(suite_dir/'testSuite.xml')
    result = []
    for index, entry in enumerate(suite.findall(TDL + 'testcase')):
        testcase = ET.parse(suite_dir/'testCases'/(entry.attrib['id'] + '.xml'))
        targets = testcase.findall(f'.//{TDL}input[@name="type"]')
        if len(targets) != 1:
            raise ValueError(f'Expected one release target in {entry.attrib["id"]}')
        target = targets[0].text.strip().strip('"')
        rule = rulesets[target]
        suffix = re.sub(r'[^A-Z0-9]', '_', (rule['profile'] + '_' + rule['profileVersion']).upper())
        # Keep existing saved sessions and the PHMR default used by API smoke tests.
        variable = 'ITB_ACTIVE_SESSION_ID' if target == 'phmr.v2.1.0' else f'ITB_{suffix}_SESSION_ID'
        result.append(dict(index=index, target=target, label=rule['label'], variable=variable))
    if len(result) != len(rulesets) or {s['target'] for s in result} != set(rulesets):
        raise ValueError('Expected exactly one session slot for every registered release')
    if len({s['variable'] for s in result}) != len(result):
        raise ValueError('Release session variable names collide')
    return result


if __name__ == '__main__':
    for session in sessions():
        print(session['index'], session['variable'], session['label'], sep='\t')
