#!/usr/bin/env python3
"""Check both deployment modes against the same release catalogue and validator."""
import json
import os
from pathlib import Path
import subprocess
import tempfile
import unittest
import xml.etree.ElementTree as ET
import zipfile

ROOT = Path(__file__).resolve().parents[1]
NS = {'t': 'http://www.gitb.com/tdl/v1/', 'c': 'http://www.gitb.com/core/v1/'}

class Packaging(unittest.TestCase):
    def package(self, enabled, kind='upload'):
        with tempfile.TemporaryDirectory() as directory:
            archive = Path(directory)/'suite.zip'
            subprocess.run([str(ROOT/'get-up-and-running/package-test-suite.sh'), str(archive), kind], env={**os.environ, 'ITB_ENABLE_XDS': str(enabled).lower()}, check=True, capture_output=True)
            with zipfile.ZipFile(archive) as zipped:
                return {n: ET.fromstring(zipped.read(n)) for n in zipped.namelist() if n.endswith('.xml') and not n.startswith('resources/')}

    def test_both_modes_preserve_ids_and_exact_validator_targets(self):
        upload, xds = self.package(False), self.package(True)
        self.assertEqual(set(upload), set(xds))
        cases = [key for key in upload if key.startswith('testCases/')]
        self.assertEqual(len(json.loads((ROOT / "cda-validator/domain/cda-dk/rulesets.json").read_text())["rulesets"]), len(cases))
        for key in cases:
            with self.subTest(case=key):
                self.assertEqual(upload[key].get('id'), xds[key].get('id'))
                for root in (upload[key], xds[key]):
                    self.assertTrue(root.find('t:metadata/c:name', NS).text.startswith('Validate '))
                    verify = root.findall('.//t:verify', NS)
                    self.assertEqual(1, len(verify))
                    self.assertEqual('$DOMAIN{cdaValidator}', verify[0].get('handler'))
                    self.assertIsNotNone(root.find('.//t:request[@inputType="UPLOAD"]', NS))
                self.assertEqual(upload[key].find('.//t:input[@name="type"]', NS).text, xds[key].find('.//t:input[@name="type"]', NS).text)
                self.assertIsNone(upload[key].find('.//t:bptxn', NS))
                self.assertEqual('$DOMAIN{xdsConnector}', xds[key].find('.//t:bptxn', NS).get('handler'))
                source = xds[key].find('.//t:request[@name="source"]', NS)
                self.assertEqual('Local file upload,IHE XDS (DDS) retrieval', source.get('options'))
                self.assertEqual(source.get('options'), source.get('optionLabels'))
                self.assertEqual(['choices', 'search', 'filter', 'retrieve'], [e.text for e in xds[key].findall('.//t:operation', NS)])
                for name in ('typeCode', 'formatCode'):
                    self.assertEqual('SELECT_MULTIPLE', xds[key].find('.//t:request[@name="' + name + '"]', NS).get('inputType'))
                for name in ('registry', 'professional', 'typeCode', 'formatCode', 'document', 'action', 'repositoryMode', 'repositories'):
                    request = xds[key].find('.//t:request[@name="' + name + '"]', NS)
                    self.assertEqual(request.get('optionLabels'), request.get('options'), name)
                self.assertEqual('$document', xds[key].find('.//t:input[@name="xml"]', NS).text)
                self.assertEqual('false', xds[key].find('t:metadata/c:update', NS).get('resetTestHistory'))

    def test_registry_selection_is_conditional_and_passed_to_search(self):
        root = self.package(True)['testCases/validate-phmr_v2_1_0-manual.xml']
        conditional = root.find('.//t:if[@desc="Choose a configured registry"]', NS)
        self.assertEqual('number($xdsChoices{registryCount}) > 1', conditional.find('t:cond', NS).text)
        self.assertIsNotNone(conditional.find('t:then/t:interact[@id="xdsRegistry"]', NS))
        self.assertEqual('$xdsChoices{defaultRegistry}', root.find('.//t:assign[@to="selectedRegistry"]', NS).text)
        self.assertEqual('$selectedRegistry', root.find('.//t:process[@id="xdsResults"]/t:input[@name="registry"]', NS).text)
        self.assertIsNone(root.find('.//t:process[@id="xdsDocument"]/t:input[@name="registry"]', NS))

    def test_xds_errors_are_logged_before_exit(self):
        root = self.package(True)['testCases/validate-phmr_v2_1_0-manual.xml']
        for parent in root.iter():
            steps = list(parent)
            for index, step in enumerate(steps):
                if step.tag == '{' + NS['t'] + '}process':
                    self.assertEqual('false', step.get('stopOnError'))
                    guard_index = index + 1
                    if step.get('id') == 'xdsDocument':
                        preview_log = steps[guard_index]
                        self.assertEqual('{' + NS['t'] + '}log', preview_log.tag)
                        self.assertEqual('INFO', preview_log.get('level'))
                        self.assertEqual('$xdsDocument{retrievedDocumentLog}', preview_log.text)
                        guard_index += 1
                    guard = steps[guard_index]
                    self.assertIn('$STEP_STATUS{' + step.get('id') + '}', guard.find('t:cond', NS).text)
                    log = guard.find('t:then/t:log', NS)
                    self.assertEqual('ERROR', log.get('level'))
                    self.assertIn('{errorCode}', log.text)
                    self.assertIn('{errorMessage}', log.text)
                    self.assertNotIn('patientId', log.text)
                    self.assertEqual('false', guard.find('t:then/t:exit', NS).get('success'))
        self.assertEqual(1, len(root.findall('.//t:eptxn', NS)))

    def test_pending_session_must_survive_engine_restart(self):
        import importlib.util
        spec = importlib.util.spec_from_file_location('session_restart', ROOT/'get-up-and-running/session-survived-restart.py')
        module = importlib.util.module_from_spec(spec); spec.loader.exec_module(module)
        boot = '2026-09-14T14:06:16.123456789Z'
        self.assertFalse(module.survived({'startTime': '2026-09-14T13:58:49Z'}, boot))
        self.assertTrue(module.survived({'startTime': '2026-09-14T14:06:17Z'}, boot))
        self.assertTrue(module.survived({'startTime': '2026-09-14T16:06:17+02:00'}, boot))
        self.assertFalse(module.survived({}, boot))

    def test_setup_check_never_depends_on_xds(self):
        for root in self.package(True, 'setup-check').values():
            self.assertIsNone(root.find('.//t:bptxn', NS))

if __name__ == '__main__':
    unittest.main()
