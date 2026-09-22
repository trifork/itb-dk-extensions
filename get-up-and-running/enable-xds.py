#!/usr/bin/env python3
"""Add the shared optional XDS interaction to staged release tests, preserving IDs."""
import copy
import sys
from pathlib import Path
import xml.etree.ElementTree as ET

TDL = 'http://www.gitb.com/tdl/v1/'
CORE = 'http://www.gitb.com/core/v1/'
ET.register_namespace('', TDL)
ET.register_namespace('gitb', CORE)
ns = {'t': TDL, 'c': CORE}
staged = Path(sys.argv[1])
flow = ET.parse(Path(__file__).with_name('xds-flow.xml')).getroot()
for path in sorted((staged / 'testCases').glob('*.xml')):
    tree = ET.parse(path)
    steps = tree.find('t:steps', ns)
    upload = steps.find("t:interact[@id='submission']", ns)
    assert upload is not None, path
    steps.remove(upload)
    additions = copy.deepcopy(flow)
    then = additions.find('t:if/t:then', ns)
    then.append(upload)
    ET.SubElement(then, f'{{{TDL}}}assign', {'to': 'document', 'type': 'binary'}).text = '$submission{document}'
    for index, step in enumerate(additions):
        steps.insert(index, step)
    steps.find("t:verify[@id='validateSubmission']/t:input[@name='xml']", ns).text = '$document'
    tree.find('t:metadata/c:version', ns).text = '2.4.1'
    tree.find('t:output/t:failure/t:default', ns).text = '"The test failed. Open the failed step to distinguish XDS access or retrieval errors from CDA validation findings."'
    ET.indent(tree, space='    ')
    tree.write(path, encoding='UTF-8', xml_declaration=True)
