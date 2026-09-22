#!/usr/bin/env python3
"""Check Maven-to-CI summaries without invoking a validator."""
import hashlib
import json
from pathlib import Path
import runpy
import tempfile
import unittest
import xml.etree.ElementTree as ET
from unittest.mock import patch

summary = runpy.run_path(str(Path(__file__).with_name('write-summary.py')))
render = summary['render']


class ReportingTests(unittest.TestCase):
    def test_expected_rejection_failure_and_unreached_tests_are_distinct(self):
        expected = dict(result='FAILURE', errors=3, warnings=0)
        actual = dict(result='FAILURE', errors=4, warnings=0)
        samples = [dict(file='samples/' + name + '.xml', validationType='apd.v2.0.1', expected=expected)
                   for name in ('expected-invalid', 'broken', 'not-reached')]
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            (root/'samples').mkdir()
            (root/'samples/validation-cases.json').write_text(json.dumps(samples))
            integration = root/'failsafe-reports'; integration.mkdir()
            suite = ET.Element('testsuite')
            for sample in samples[:2]:
                case = ET.SubElement(suite, 'testcase', classname='com.trifork.itb.integration.CdaSamplesIT',
                                     name=f"matchesPublishedExpectation[{sample['file']} [{sample['validationType']}]]")
                if sample == samples[1]:
                    ET.SubElement(case, 'failure', message='Unexpected <script>alert(1)</script> | result')
                folder = root/'example-results'; folder.mkdir(exist_ok=True)
                name = hashlib.sha256((sample['validationType'] + ':' + sample['file']).encode()).hexdigest() + '.json'
                (folder/name).write_text(json.dumps(actual if sample == samples[1] else expected))
            ET.ElementTree(suite).write(integration/'TEST-samples.xml')
            with patch.dict(render.__globals__, ROOT=root):
                report = render(root, root, 'https://github.com/example/artifact', integration_directory=integration)
            self.assertIn('✅ 1 passed · ❌ 1 failed · ⏭️ 1 not run', report)
            self.assertIn('FAILURE · 3 errors · 0 warnings', report)
            self.assertIn('FAILURE · 4 errors · 0 warnings', report)
            self.assertNotIn('<script>', report)
            self.assertIn('&lt;script&gt;', report)
            self.assertIn('[Download validation reports and logs](https://github.com/example/artifact)', report)

    def test_no_results_does_not_claim_success(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            report = render(root, root, steps={'Docker': 'skipped'}, integration_directory=root)
            self.assertIn('✅ 0 passed', report)
            samples = json.loads((Path(__file__).resolve().parents[2]/'samples/validation-cases.json').read_text())
            self.assertIn(f'⏭️ {len(samples)} not run', report)
            for sample in samples:
                self.assertIn(sample['file'].removeprefix('samples/'), report)
            self.assertIn('No test report was produced', report)

    def test_jupiter_display_names_match_samples_without_double_counting(self):
        sample = dict(file='samples/example.xml', validationType='apd.v2.0.1',
                      expected=dict(result='SUCCESS', errors=0, warnings=0))
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            (root/'samples').mkdir()
            (root/'samples/validation-cases.json').write_text(json.dumps([sample]))
            suite = ET.Element('testsuite')
            ET.SubElement(suite, 'testcase', classname='com.trifork.itb.integration.CdaSamplesIT',
                          name='matchesPublishedExpectation(String, String, JsonNode) samples/example.xml [apd.v2.0.1]')
            ET.ElementTree(suite).write(root/'TEST-samples.xml')
            with patch.dict(render.__globals__, ROOT=root):
                report = render(root, root/'no-units', integration_directory=root)
            self.assertIn('✅ 1 passed · ❌ 0 failed · ⏭️ 0 not run', report)

    def test_java_failures_and_skips_are_reported(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            (root/'TEST-demo.xml').write_text('<testsuite><testcase name="ok"/><testcase name="bad"><failure message="bad assertion"/></testcase><testcase name="skipped"><skipped/></testcase></testsuite>')
            report = render(root, root, integration_directory=root/'absent')
            self.assertIn('| ok | Java plugin | ✅ Passed |', report)
            self.assertIn('| bad | Java plugin | ❌ Failed |', report)
            self.assertIn('| skipped | Java plugin | ⏭️ Not run |', report)
            self.assertIn('bad assertion', report)

    def test_integration_initialization_failure_is_not_lost(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            (root/'TEST-init.xml').write_text('<testsuite><testcase classname="com.trifork.itb.integration.CdaSamplesIT" name="initializationError"><error message="No catalogue"/></testcase></testsuite>')
            report = render(root, root/'absent', integration_directory=root)
            self.assertIn('❌ 1 failed', report)
            self.assertIn('No catalogue', report)


if __name__ == '__main__':
    unittest.main()
