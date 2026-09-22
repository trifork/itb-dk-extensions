#!/usr/bin/env python3
"""Check that the example report preserves findings and never claims unrun/stale results."""
import json
from pathlib import Path
import sys
import tempfile
import unittest
from unittest.mock import patch
import xml.etree.ElementTree as ET

sys.path.insert(0, str(Path(__file__).resolve().parents[2] / 'scripts'))
import example_report as report


class ExampleReportTests(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory()
        self.addCleanup(self.temp.cleanup)
        self.root = Path(self.temp.name)
        self.addCleanup(patch.stopall)
        patch.object(report, 'ROOT', self.root).start()
        self.sample = dict(file='samples/example.xml', validationType='profile.v1')
        for directory in ('samples', 'cda-validator/domain/cda-dk', 'docs/pro-conformance', 'docs/cda-conformance'):
            (self.root / directory).mkdir(parents=True, exist_ok=True)
        (self.root / self.sample['file']).write_text('<example/>')
        (self.root / 'samples/validation-cases.json').write_text(json.dumps([self.sample]))
        (self.root / 'cda-validator/domain/cda-dk/rulesets.json').write_text(json.dumps(dict(rulesets=[
            dict(id='profile.v1', label='Profile 1', source='https://svn.medcom.dk/spec.pdf')
        ])))
        for directory in ('pro-conformance', 'cda-conformance'):
            (self.root / 'docs' / directory / 'rules.json').write_text('[]')
        self.results = self.root / 'results'
        self.output = self.root / 'docs/report.md'

    def save(self):
        tar = ET.fromstring('''<report><result>FAILURE</result><counters>
            <nrOfErrors>2</nrOfErrors><nrOfWarnings>0</nrOfWarnings></counters><reports>
            <error><assertionID>R1</assertionID><description>Missing x | y</description><location>/a</location></error>
            <error><assertionID>R1</assertionID><description>Missing x | y</description><location>/b</location></error>
            </reports></report>''')
        report.save_result(self.sample, tar, self.results)

    def test_groups_repeated_findings_without_losing_locations_in_raw_results(self):
        self.save()
        self.assertTrue(report.render(self.results, self.output))
        markdown = self.output.read_text()
        self.assertIn('| FAILURE | 2 | 0 | 1 |', markdown)
        self.assertIn('| error | R1 | 2 | Missing x \\| y | /a |', markdown)
        raw = json.loads((self.results / report.result_name(self.sample)).read_text())
        self.assertEqual(['/a', '/b'], [f['location'] for f in raw['findings']])

    def test_missing_results_are_explicitly_not_executed(self):
        self.assertFalse(report.render(self.results, self.output))
        self.assertIn('**0 / 1**', self.output.read_text())
        self.assertIn('## Not executed', self.output.read_text())

    def test_changed_sample_cannot_reuse_old_findings(self):
        self.save()
        (self.root / self.sample['file']).write_text('<changed/>')
        with self.assertRaises(AssertionError):
            report.render(self.results, self.output)


if __name__ == '__main__':
    unittest.main()
