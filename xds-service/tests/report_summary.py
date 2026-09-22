#!/usr/bin/env python3
"""Report completed, failed and unreached XDS checks from JUnit artifacts."""
from pathlib import Path
import xml.etree.ElementTree as ET

root = Path(__file__).resolve().parents[2]
print('## XDS integration checks\n')
print('| Check | Result |\n| --- | --- |')
groups = [
    ('XDS service unit / SOAP tests', list((root/'xds-service/target/surefire-reports').glob('TEST-*.xml')) + [p for p in (root/'xds-service/target/failsafe-reports').glob('TEST-*.xml') if not p.name.endswith('ItbFlowIT.xml')]),
    ('Combined XDS service startup', [root/'test-results/xds/backend.xml']),
    ('Real ITB interactions', list((root/'xds-service/target/failsafe-reports').glob('TEST-*ItbFlowIT.xml'))),
    ('Bootstrap modes and reuse', [root/'test-results/xds/bootstrap.xml']),
]
for label, paths in groups:
    paths = [p for p in paths if p.is_file()]
    if not paths:
        print(f'| {label} | ⚪ Not reached |')
    for path in paths:
        for case in ET.parse(path).iter('testcase'):
            status = '❌ Failed' if case.find('failure') is not None or case.find('error') is not None else '⚪ Not reached' if case.find('skipped') is not None else '✅ Passed'
            name = case.get('name', label).replace('|','/').replace('\n',' ')
            print(f'| {name} | {status} |')
print('\nThese checks use synthetic DDS responses. Live TEST1 authentication remains unverified; named credentials must be configured for live use.')
