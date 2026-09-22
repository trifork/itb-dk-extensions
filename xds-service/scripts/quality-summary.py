#!/usr/bin/env python3
"""Summarize actual CI outcomes without treating missing reports as passing checks."""
import json
import os
from pathlib import Path
import xml.etree.ElementTree as ET

ROOT = Path(__file__).resolve().parents[1] / 'target'
print('## XDS quality gates\n')
print('| Gate | Result |\n| --- | --- |')
for name, variable in [('Tests, Spotless, PMD, CPD and coverage', 'MAVEN_OUTCOME'),
                       ('Pinned Sonar analyzer installation', 'INSTALL_OUTCOME'),
                       ('Sonar Java / symbolic execution', 'SONAR_OUTCOME')]:
    result = os.environ.get(variable, 'not reached')
    print(f'| {name} | {result} |')
coverage = ROOT / 'site/jacoco/jacoco.xml'
if coverage.is_file():
    for counter in ET.parse(coverage).getroot().findall('counter'):
        if counter.get('type') in ('LINE', 'BRANCH'):
            covered, missed = int(counter.get('covered')), int(counter.get('missed'))
            ratio = 100 * covered / (covered + missed) if covered + missed else 0
            print(f"| {counter.get('type').title()} coverage | {ratio:.1f}% |")
sonar = ROOT / 'reports/sonar-java.json'
if sonar.is_file():
    report = json.loads(sonar.read_text())
    print(f"| Sonar findings | {len(report['issues'])} across {report['files']} files / {report['rules']} rules |")
else:
    print('| Sonar report | Not produced |')
print('\nSelf-contained Sonar Java analysis; no hosted SonarQube server is used.')
