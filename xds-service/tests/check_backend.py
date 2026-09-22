#!/usr/bin/env python3
"""Readiness check for the combined service; no outbound STS/XDS operations."""
from pathlib import Path
import subprocess
import time
import xml.etree.ElementTree as ET

root = Path(__file__).resolve().parents[2]
result = None
for attempt in range(60):
    result = subprocess.run(['docker', 'compose', '--profile', 'xds', 'exec', '-T', 'xds-api', 'java', '-cp', '/app/probe', 'com.trifork.ihexdsapi.gitb.ReadinessProbe'], cwd=root, capture_output=True, text=True, timeout=15)
    if result.returncode == 0:
        break
    time.sleep(2)
out = root/'test-results/xds'; out.mkdir(parents=True, exist_ok=True)
suite = ET.Element('testsuite', name='Combined XDS service startup', tests='1', failures=str(int(result.returncode != 0)))
case = ET.SubElement(suite, 'testcase', name='Combined REST/GITB service is locally ready')
if result.returncode:
    ET.SubElement(case, 'failure').text = 'Combined service did not become ready; inspect startup and certificate configuration.'
ET.ElementTree(suite).write(out/'backend.xml', encoding='utf-8', xml_declaration=True)
print('Combined XDS service startup: ' + ('PASS (no live STS check)' if result.returncode == 0 else 'FAIL'))
raise SystemExit(result.returncode)
