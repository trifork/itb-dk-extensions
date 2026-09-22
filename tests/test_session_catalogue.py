#!/usr/bin/env python3
"""Check release-to-session mapping, including saved-state compatibility."""
import json
from pathlib import Path
import shutil
import sys
import tempfile
import unittest
import xml.etree.ElementTree as ET

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT/'get-up-and-running'))
from session_catalogue import sessions, TDL


class SessionCatalogue(unittest.TestCase):
    def setUp(self):
        self.directory = tempfile.TemporaryDirectory()
        self.addCleanup(self.directory.cleanup)
        self.root = Path(self.directory.name)
        shutil.copytree(ROOT/'get-up-and-running/test-suite', self.root/'get-up-and-running/test-suite')
        (self.root/'cda-validator/domain/cda-dk').mkdir(parents=True)
        shutil.copyfile(ROOT/'cda-validator/domain/cda-dk/rulesets.json', self.root/'cda-validator/domain/cda-dk/rulesets.json')
        self.suite_path = self.root/'get-up-and-running/test-suite/testSuite.xml'

    def test_all_releases_preserve_legacy_session_slots(self):
        slots = {s['target']: s['variable'] for s in sessions(self.root)}
        expected = {r['id'] for r in json.loads((self.root/'cda-validator/domain/cda-dk/rulesets.json').read_text())['rulesets']}
        self.assertEqual(expected, set(slots))
        self.assertEqual('ITB_ACTIVE_SESSION_ID', slots['phmr.v2.1.0'])
        self.assertEqual('ITB_PHMR_1_3_SESSION_ID', slots['phmr.v1.3'])
        self.assertEqual('ITB_QFDD_1_2_SESSION_ID', slots['qfdd.v1.2'])
        self.assertEqual(len(slots), len(set(slots.values())))

    def test_reordering_suite_preserves_slots_and_changes_deployment_indices(self):
        before = sessions(self.root)
        tree = ET.parse(self.suite_path)
        cases = tree.findall(TDL + 'testcase')
        for case in cases:
            tree.getroot().remove(case)
        tree.getroot().extend(reversed(cases))
        tree.write(self.suite_path)
        after = sessions(self.root)
        self.assertEqual(list(reversed([s['variable'] for s in before])), [s['variable'] for s in after])
        self.assertEqual(list(range(len(after))), [s['index'] for s in after])

    def test_new_release_automatically_gets_a_session(self):
        next_index = len(sessions(self.root))
        path = self.root/'cda-validator/domain/cda-dk/rulesets.json'
        catalogue = json.loads(path.read_text())
        catalogue['rulesets'].append(dict(id='example.v4.2', profile='example', profileVersion='4.2', label='Example 4.2'))
        path.write_text(json.dumps(catalogue))
        tree = ET.parse(self.suite_path)
        ET.SubElement(tree.getroot(), TDL + 'testcase', id='example')
        tree.write(self.suite_path)
        (self.suite_path.parent/'testCases/example.xml').write_text(
            '<testcase xmlns="http://www.gitb.com/tdl/v1/"><input name="type">"example.v4.2"</input></testcase>')
        self.assertEqual(dict(index=next_index, target='example.v4.2', label='Example 4.2', variable='ITB_EXAMPLE_4_2_SESSION_ID'), sessions(self.root)[-1])

    def test_missing_release_is_rejected(self):
        tree = ET.parse(self.suite_path)
        tree.getroot().remove(tree.findall(TDL + 'testcase')[0])
        tree.write(self.suite_path)
        with self.assertRaisesRegex(ValueError, 'every registered release'):
            sessions(self.root)


if __name__ == '__main__':
    unittest.main()
