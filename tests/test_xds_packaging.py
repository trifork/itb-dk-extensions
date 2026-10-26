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
    def test_published_search_catalogue_preserves_codes_and_schemes(self):
        # Runtime defaults deliberately stay outside the Docker build context.
        # Check their catalogue here; Java tests exercise binding and query mapping.
        properties = dict(line.split('=', 1) for line in
                          (ROOT/'xds-service/application.properties').read_text().splitlines()
                          if '=' in line and not line.startswith('#'))
        types = properties['type.code.codes'].split(';')
        formats = properties['format.code.codes'].split(';')
        self.assertEqual(18, len(set(types)))
        self.assertEqual(28, len(set(formats)))
        self.assertEqual(len(types), len(set(types)))
        self.assertEqual(len(formats), len(set(formats)))
        for kind in ('type', 'format'):
            self.assertEqual(len(properties[f'{kind}.code.codes'].split(';')),
                             len(properties[f'{kind}.code.names'].split(';')))
        for code in ('CMR', 'PDC', 'MADC', 'PFR', 'PSCR', 'PMR'):
            with self.subTest(code=code):
                self.assertIn(code, types)
                self.assertEqual('1.2.208.184.100.1', properties[f'type.code.scheme-overrides[{code}]'])
        for code in ('53576-5', '74468-0', '74465-6', '11502-2', '56446-8',
                     '39289-4', '39290-2', '103140-0', '11450-4', '81215-6',
                     '57059-8', '28615-3'):
            with self.subTest(code=code):
                self.assertIn(code, types)
                self.assertEqual('2.16.840.1.113883.6.1',
                                 properties.get(f'type.code.scheme-overrides[{code}]', properties['type.code.scheme']))
        self.assertEqual('1.2.208.184.100.10', properties['format.code.scheme'])
        for code in ('pdc-v2.0', 'pdc-v3.0', 'apd-v2.0.1', 'cpd-v1.0.1',
                     'cpd-v2.0', 'phad-v1.0', 'pmr-v1.0', 'prf-v1.0',
                     'pscr-v1.0', 'phmr', 'phmr-v2.1', 'qfdd-v1.2', 'qrd-v1.3'):
            with self.subTest(code=code):
                self.assertIn(f'urn:ad:dk:medcom:{code}:full', formats)

    def test_default_routes_keep_dds_and_sfsk_endpoints_paired(self):
        properties = dict(line.split('=', 1) for line in
                          (ROOT/'xds-service/application.properties').read_text().splitlines()
                          if '=' in line and not line.startswith('#'))
        ids = [properties[f'xds.registries[{i}].id'] for i in range(4)]
        self.assertEqual(['test1', 'test2', 'sfsk-test1', 'sfsk-test2'], ids)
        for index, environment in ((2, 'test1'), (3, 'test2')):
            for transaction in ('iti18', 'iti43'):
                self.assertIn(f'https://{environment}-cnsp.ekstern-test.nspop.dk:8443/sfsk/{transaction}',
                              properties[f'xds.registries[{index}].{transaction}-endpoint'])
        self.assertEqual(properties['xds.registries[0].sts-endpoint'], properties['xds.registries[2].sts-endpoint'])
        self.assertEqual(properties['xds.registries[1].sts-endpoint'], properties['xds.registries[3].sts-endpoint'])

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
                self.assertEqual(['choices', 'queryChoices', 'search', 'filter', 'retrieve'], [e.text for e in xds[key].findall('.//t:operation', NS)])
                for name in ('entryTypes', 'typeCode', 'formatCode'):
                    self.assertEqual('SELECT_MULTIPLE', xds[key].find('.//t:interact[@id="xdsQuery"]/t:request[@name="' + name + '"]', NS).get('inputType'))
                for name in ('registry', 'professional', 'entryTypes', 'typeCode', 'formatCode', 'document', 'action', 'repositoryMode', 'repositories'):
                    request = xds[key].find('.//t:request[@name="' + name + '"]', NS)
                    self.assertEqual(request.get('optionLabels'), request.get('options'), name)
                entry_type = xds[key].find('.//t:request[@name="entryTypes"]', NS)
                self.assertEqual('true', entry_type.get('required'))
                self.assertEqual('$xdsChoices{defaultEntryTypes}', entry_type.get('default'))
                for form_id in ('xdsQuery', 'xdsStamkortQuery'):
                    identity = xds[key].find('.//t:interact[@id="' + form_id + '"]/t:request[@name="professional"]', NS)
                    self.assertEqual('$xdsQueryChoices{defaultProfessional}', identity.get('default'))
                self.assertEqual('$search_entryTypes', xds[key].find('.//t:input[@name="entryTypes"]', NS).text)
                self.assertEqual('$document', xds[key].find('.//t:input[@name="xml"]', NS).text)
                self.assertEqual('false', xds[key].find('t:metadata/c:update', NS).get('resetTestHistory'))

    def test_stamkort_form_only_exposes_applicable_fields(self):
        root = self.package(True)['testCases/validate-phmr_v2_1_0-manual.xml']
        form = root.find('.//t:interact[@id="xdsStamkortQuery"]', NS)
        self.assertEqual(['patientId', 'professional', 'formatCode'],
                         [item.get('name') for item in form.findall('t:request', NS)])
        self.assertEqual('SELECT_SINGLE', form.find('t:request[@name="formatCode"]', NS).get('inputType'))
        self.assertEqual('$xdsQueryChoices{defaultProfessional}', form.find('t:request[@name="professional"]', NS).get('default'))

    def test_date_filters_declare_utc_picker_metadata(self):
        root = self.package(True)['testCases/validate-phmr_v2_1_0-manual.xml']
        form = root.find('.//t:interact[@id="xdsQuery"]', NS)
        dates = {'startFromDate', 'startToDate', 'endFromDate', 'endToDate'}
        for request in form.findall('t:request', NS):
            if request.get('name') in dates:
                self.assertEqual('TEXT', request.get('inputType'))
                self.assertEqual('text/plain;format=date-time;timezone=UTC', request.get('mimeType'))
                self.assertNotEqual('true', request.get('required'))
            else:
                self.assertIsNone(request.get('mimeType'))

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

    def test_pending_session_restart_cli_accepts_itb_1302_dates(self):
        # The status API's default date format is UTC without an explicit offset.
        # Exercise the real stdin/exit-code interface called by setup-itb.sh.
        boot = '2026-10-26T14:45:13.123456789Z'
        for start, expected in (
                ('26/10/2026 14:45:12', 1),
                ('26/10/2026 14:45:13', 0),
                ('26/10/2026 14:45:14', 0),
                ('2026-10-26T15:45:13+01:00', 0),
                ('2026-10-26T14:45:12Z', 1),
                ('invalid', 1),
                (None, 1)):
            with self.subTest(start=start):
                result = subprocess.run(
                    ['python3', str(ROOT/'get-up-and-running/session-survived-restart.py'), boot],
                    input=json.dumps({'sessions': [{'startTime': start}]}),
                    env={**os.environ, 'TZ': 'Europe/Copenhagen'},
                    capture_output=True, text=True)
                self.assertEqual(expected, result.returncode, result.stderr)
                self.assertEqual('', result.stderr)

if __name__ == '__main__':
    unittest.main()
