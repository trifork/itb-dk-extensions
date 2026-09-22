#!/usr/bin/env python3
"""Verify session reuse and mode changes without deleting any ITB history."""
import os
from pathlib import Path
import subprocess
import sys
import xml.etree.ElementTree as ET
import shlex

ROOT = Path(__file__).resolve().parents[2]

def read_state(path):
    return {key: ' '.join(shlex.split(value)) for line in path.read_text().splitlines()
            if '=' in line for key, value in [line.split('=', 1)]}

state = Path(os.environ.get('ITB_STATE_FILE', ROOT/'get-up-and-running/.itb-bootstrap.env'))
sys.path.insert(0, str(ROOT/'get-up-and-running'))
from session_catalogue import sessions
keys = [s['variable'] for s in sessions()]
def ids():
    values = read_state(state)
    result = tuple(values[key] for key in keys)
    assert all(result) and len(set(result)) == len(keys), 'Every release needs its own saved session'
    return result
def setup(enabled):
    subprocess.run([str(ROOT/'get-up-and-running/setup-itb.sh')], env={**os.environ, 'ITB_ENABLE_XDS': str(enabled).lower(), 'ITB_RUN_EXAMPLE': 'false'}, check=True, stdout=subprocess.DEVNULL)

suite = ET.Element('testsuite', name='Bootstrap session preservation', tests='1')
case = ET.SubElement(suite, 'testcase', name='Reuse pending sessions; replace defaults when source mode changes')
try:
    before = ids(); setup(True); assert ids() == before
    setup(False); upload = ids(); assert all(a != b for a,b in zip(before, upload))
    setup(False); assert ids() == upload
    setup(True); restored = ids(); assert all(a != b for a,b in zip(upload, restored))
    setup(True); assert ids() == restored
except Exception:
    ET.SubElement(case, 'failure').text = 'Bootstrap did not preserve/reuse/replace session slots as expected.'
    raise
finally:
    out = ROOT/'test-results/xds'; out.mkdir(parents=True, exist_ok=True)
    ET.ElementTree(suite).write(out/'bootstrap.xml', encoding='utf-8', xml_declaration=True)
print('Bootstrap source modes and pending-session reuse: PASS')
