#!/usr/bin/env python3
"""Check release catalogue, artifact wiring and version-specific test descriptions."""
import json
import hashlib
from pathlib import Path
import xml.etree.ElementTree as ET

ROOT = Path(__file__).resolve().parents[1]


def main():
    catalogue = json.loads((ROOT / "cda-validator/domain/cda-dk/rulesets.json").read_text())
    props = {}
    for line in (ROOT / "cda-validator/domain/cda-dk/config.properties").read_text().splitlines():
        if line.strip() and not line.lstrip().startswith("#"):
            key, value = line.split("=", 1)
            assert key.strip() not in props, f"Duplicate property: {key}"
            props[key.strip()] = value.strip()
    profiles = [p.strip() for p in props["validator.type"].split(",")]
    configured = {
        f"{profile}.{version.strip()}"
        for profile in profiles
        for version in props[f"validator.typeOptions.{profile}"].split(",")
    }
    ids = {r["id"] for r in catalogue["rulesets"]}
    assert len(ids) == len(catalogue["rulesets"]), "Duplicate ruleset IDs"
    assert configured == ids, "Catalogue and enabled profile/version options differ"
    for ruleset in catalogue["rulesets"]:
        full_type = ruleset["id"]
        assert full_type == f'{ruleset["profile"]}.v{ruleset["profileVersion"]}'
        assert ruleset["source"].startswith("https://svn.medcom.dk/")
        assert ruleset["status"] == "partial-coverage"
        assert props[f"validator.schemaFile.{full_type}"] == ruleset["schema"]
        assert (ROOT / "cda-validator/domain/cda-dk" / ruleset["schema"]).is_file()
        assert [p.strip() for p in props[f"validator.schematronFile.{full_type}"].split(",")] == ruleset["schematron"]
        for path in ruleset["schematron"]:
            assert (ROOT / "cda-validator/domain/cda-dk" / path).exists()
        assert props[f"validator.completeTypeOptionLabel.{full_type}"] == ruleset["label"]
    assert not any(key.startswith("validator.typeAlias.") for key in props), "Version selection must be explicit"
    cases = json.loads((ROOT / "samples/validation-cases.json").read_text())
    assert {c["file"] for c in cases} == {
        p.relative_to(ROOT).as_posix() for p in (ROOT / "samples").glob("*/*.xml")
    }, "Every sample must have an explicit version and expected result"
    assert {c["validationType"] for c in cases} == ids
    for sample in cases:
        if "sourceSha256" in sample:
            assert sample["source"].startswith("https://svn.medcom.dk/")
            assert hashlib.sha256((ROOT / sample["file"]).read_bytes()).hexdigest() == sample["sourceSha256"], \
                f"Published sample bytes changed: {sample['file']}"
    tested = set()
    suite = ET.parse(ROOT / "get-up-and-running/test-suite/testSuite.xml")
    suite_cases = [e.attrib["id"] for e in suite.findall('{http://www.gitb.com/tdl/v1/}testcase')]
    files = list((ROOT / "get-up-and-running/test-suite/testCases").glob("*.xml"))
    assert len(suite_cases) == len(ids), "Expose exactly one upload test per release"
    assert set(suite_cases) == {p.stem for p in files}, "Suite references and packaged tests differ"
    labels = {r["id"]: r["label"] for r in catalogue["rulesets"]}
    for path in files:
        tree = ET.parse(path)
        assert tree.find('.//{http://www.gitb.com/tdl/v1/}request[@inputType="UPLOAD"]') is not None, \
            f"Setup-only tests must not appear in the upload suite: {path}"
        for element in tree.findall('.//{http://www.gitb.com/tdl/v1/}input[@name="type"]'):
            target = element.text.strip().strip('"')
            assert target in ids, f"Unpinned test: {path}"
            assert target not in tested, f"Duplicate user-facing validation for {target}"
            tested.add(target)
            meta = tree.find('{http://www.gitb.com/tdl/v1/}metadata')
            assert labels[target] in meta.findtext('{http://www.gitb.com/core/v1/}name')
            assert target in meta.findtext('{http://www.gitb.com/core/v1/}description')
    assert tested == ids, "Every release needs an ITB test case"
    print(f"Verified {len(ids)} published release targets, artifact wiring and version-specific samples/TDL.")



if __name__ == "__main__":
    main()
