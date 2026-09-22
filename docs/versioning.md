# CDA release selection

Test names and validator selections identify the **Danish CDA profile release**.
The date when artifacts were imported and the version of a test-definition package
are separate concepts and do not appear as the profile version.

## Available targets

| Test target | API / TDL selection | Document's profile-version declaration | Published definition |
| --- | --- | --- | --- |
| APD-DK 2.0.1 | `apd.v2.0.1` | `apd-v2.0.1` | [MedCom](https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/APD-DK-v2.0.1.pdf) |
| CPD-DK 2.0.0 | `cpd.v2.0.0` | `cpd-v2.0.0` | [MedCom](https://svn.medcom.dk/svn/releases/Standarder/HL7/CPD/Dokumentation/CPD-DK.pdf) |
| PDC-DK 2.0 | `pdc.v2.0` | `pdc-v2.0` | [MedCom](https://svn.medcom.dk/svn/releases/Standarder/HL7/PDC/Dokumentation/PDC-DK-v2.0.pdf) |
| PDC-DK 3.0.0 | `pdc.v3.0.0` | `pdc-v3.0` | [MedCom](https://svn.medcom.dk/svn/releases/Standarder/HL7/PDC/Dokumentation/PDC-DK-v3.0.0.pdf) |
| PHMR-DK 1.3 | `phmr.v1.3` | `phmr-v1.3` when present (published example) | [MedCom](https://svn.medcom.dk/svn/releases/!svn/bc/2690/Standarder/HL7/PHMR/Dokumentation/PHMR-DK-Profile-v1.3.pdf) |
| PHMR-DK 2.1.0 | `phmr.v2.1.0` | `phmr-v2.1` | [MedCom](https://svn.medcom.dk/svn/releases/Standarder/HL7/PHMR/Dokumentation/PHMR-DK-v2.1.0.pdf) |
| QRD-DK 1.3.2 | `qrd.v1.3.2` | `qrd-v1.3` | [MedCom](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf) |
| QFDD-DK 1.2 | `qfdd.v1.2` | No distinct marker specified | [MedCom](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf) |
| PHAD-DK 1.0.1 | `phad.v1.0.1` | `phad-v1.0` or `phad-v1.0.0` (guide conflict) | [MedCom](https://svn.medcom.dk/svn/releases/Standarder/HL7/PHAD/Dokumentation/PHAD-DK.pdf) |
| PMR-DK 2.0.0 | `pmr.v2.0.0` | `PMR-v2.0` | [MedCom](https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf) |
| PRF-DK 3.0.0 | `prf.v3.0.0` | `PRF-v3.0` | [MedCom](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf) |
| PSCR-DK 2.0.0 | `pscr.v2.0.0` | `PSCR-v2.0` | [MedCom](https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf) |

Version markers are not always identical to the published release number.
For example, PHMR-DK **2.1.0** requires `phmr-v2.1` in
`ClinicalDocument/documentationOf/serviceEvent/id/@extension` (section 2.2.2,
CONF-PHMR-DK-65). It is not read from `ClinicalDocument/versionNumber`, which
versions an individual document. QRD's `qrd-v1.3` likewise does not identify a
particular patch release. QFDD 1.2 has no distinct release marker in its guide;
its target is selected explicitly, not inferred from document template IDs.

PHMR-DK 1.3 has a separate upload test and official sample in
`samples/phmr/phmr_v1_3_weight.xml`. Its guide does not mandate a version
marker, but the published example declares `phmr-v1.3`. The 1.3 target rejects
conflicting declarations and checks the documented two-methodCode cardinality.
An absent marker cannot prove a document is 1.3. Both PHMR releases retain
the PHMR-specific Java checks.

PDC 2.0 and 3.0.0 have separate targets and declaration checks. PDC 3.0.0 also
requires `extension="3.0"` on document template `1.2.208.184.16.1` (CONF-DK:524).
The CPD guide contains a conflicting `cpd-v2.00` spelling in prose; this
implementation uses `cpd-v2.0.0` from its constraint table and published sample.

## Using the targets in ITB

The testsuite **Danish CDA profile validation** contains an upload test for every
listed release, named for example **Validate PHMR-DK 2.1.0**. The release
also appears in the description, instructions, validation step and result text.
Startup verifies the connection using a temporary PHMR-DK 2.1.0 setup check,
then removes its suite. The user-facing tests use uploads by default;
`ITB_ENABLE_XDS=true` adds an upload/DDS choice to those same release tests. Startup
creates or reuses a pending manual session for every registered profile/version
on the same conformance statement. The session list is derived from the catalogue
and deployed test suite, so newly registered releases are included automatically.

The validator form also presents profile and release options. REST requests use
`"validationType": "phmr.v2.1.0"`. GITB TDL uses:

```xml
<verify handler="$DOMAIN{cdaValidator}" desc="Validate PHMR-DK 2.1.0">
    <input name="xml">$document</input>
    <input name="type">"phmr.v2.1.0"</input>
</verify>
```

Unversioned profile names and unknown versions are rejected. The current stock
XML-validator returns an HTTP 500 JSON error for an unknown REST selection;
this is not a CDA validation report. No selection silently falls back to another
release or a generic engine.

`gitb:version` is the revision of the test definition or testsuite. It is not the
CDA release number; the release is written explicitly in the test name and description.

## Coverage and limitations

**These are real release targets with partial conformance coverage.** A passing
result means the implemented checks passed, not that every requirement in the
published profile has been implemented. Completing that coverage is the separate
VAL-01 / VAL-02 work described in `specs.md`.

The [catalogue](../cda-validator/domain/cda-dk/rulesets.json) records the official source, exact release,
XML marker, artifact paths and coverage notes for each target. Reports include
`CDA-DK-RULESET` with the selected release and partial-coverage status. Original
Schematron and Gazelle checks are retained; their historical rule IDs must not be
assumed to refer to identically numbered clauses in newer specifications.

PHMR version mismatches point to the offending `serviceEvent/id`; section-count
errors point to `structuredBody`. Missing content is reported at an existing
ancestor because the missing element has no source line. Run
`mvn -f cda-validator/pom.xml -Pcontainer-it -Dit.test=CdaLocationsIT test-compile failsafe:integration-test failsafe:verify` against the local validator to check these
locations and missing/duplicate-element detection. Existing reports retain their
original locations; rerun validation to get the updated messages.

Added Schematron rules under `cda-validator/domain/cda-dk/sch/versions/` enforce document identity and
release declarations. PHMR 2.1.0 additionally checks its changed MCS measurement
code-system OID, NPU/DNK OID, section cardinality and selected document constraints.
QFDD's shared template IDs do not prove that a document meets all 1.2-specific
requirements. Full rule coverage, terminology bindings and the existing XSD versus
Gazelle discrepancies remain documented implementation work.

QFDD-DK 1.2 and QRD-DK 1.3.2 additionally load the source-derived
`*-conformance.sch` files. See [PRO conformance](pro-conformance.md) for exact
source clauses, interpretation decisions, regression tests and remaining gaps.
The separate paired QRD/QFDD schema is not a single-document release target.

The older QRD sample lacks the `qrd-v1.3` declaration required by QRD-DK 1.3.2;
it is now an explicit negative test. PDC and QFDD sample failures documented in
README remain expected, rather than being hidden to make the demonstration pass.

## Adding another release

1. Obtain the official definition and examples and record the exact release and
   identity/version constraints. Distinguish the Danish profile version from its
   international base specification and document revision.
2. Add applicable rules and their dependencies without overwriting another
   release's rules. Shared rule directories may be reused only while applicable
   to each selected release; split them when requirements diverge.
3. Register the target, evidence and coverage in `cda-validator/domain/cda-dk/rulesets.json`, add the
   profile option and artifact configuration in `config.properties`, and add the
   exact plugin route in `ValidationProfile`. Never strip unknown version suffixes.
4. Add positive/negative samples in `samples/validation-cases.json` and a separate
   ITB test whose name, instructions and `type` input identify that same release.
   Test release differences explicitly, including wrong-version declarations.
5. Build, check and deploy:

```bash
python3 tests/check-rulesets.py
mvn --batch-mode --no-transfer-progress -f cda-validator/pom.xml clean verify
bash cda-validator/tests/run-container-tests.sh
docker compose up -d --build --no-deps cda-validator
./run-samples.sh --check-versions
./get-up-and-running/setup-itb.sh
```

To start a fresh manual session after an ordinary testsuite update, use
`ITB_FORCE_NEW_SESSION=true ./get-up-and-running/setup-itb.sh`. Existing sessions
normally continue using their original test definitions.

For a deliberate clean local installation, run `./get-up-and-running/reset.sh`.
It removes this Compose project's containers, volumes, test history and generated
bootstrap state, then runs `start.sh`. New credentials are saved in the usual
`.itb-users.env` file. This operation is intended only when that data can be discarded.

## Additional source-derived profiles

PHAD-DK 1.0.1, PMR-DK 2.0.0, PRF-DK 3.0.0 and PSCR-DK 2.0.0 are now registered with one ITB test each. Their release markers and coverage limits are in [the catalogue](../cda-validator/domain/cda-dk/rulesets.json); [source-derived conformance](cda-conformance.md) documents conflicting guide text and the example report. PHAD’s printed markers do not uniquely distinguish its 1.0.1 patch release.
