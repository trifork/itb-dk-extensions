# Documentation

Reference material for the Danish CDA validator and its ITB integration. The root `README.md` covers setup and everyday use. `AGENTS.md` lists which of these to read before changing what.

## Guides

| Document | Covers |
| --- | --- |
| `versioning.md` | How profile releases are named and selected in the validator, REST, SOAP and ITB tests, and how to add or retire a release. |
| `cda-conformance.md` | Source-derived Schematron checks for the CDA profiles (APD, CPD, PDC, PHMR, PHAD, PMR, PRF, PSCR): coverage, Gazelle finding severity and regression checks, specification conflicts and deliberate gaps. |
| `pro-conformance.md` | The same for the PRO profiles QFDD-DK 1.2 and QRD-DK 1.3.2. |
| `xds.md` | Enabling and configuring the optional IHE XDS integration for finding CDA documents in the Danish Document Sharing Service (DDS): credentials and vault password, TEST1 endpoints, repository labels, Docker Hub startup/publication, verification and troubleshooting. |
| `xds-service.md` | Architecture and REST/SOAP contracts of the Java `xds-service` that backs the XDS integration. |
| `dependency-review.md` | Point-in-time review of Maven dependency and plugin versions in both Java projects, dated 17 September 2026, with Gazelle access and versions rechecked on 19 September and the move from vendored artifacts to HTTPS Nexus documented. |
| `cda-validation-slides.html` | Standalone slide deck with a business-level progress overview. Open in a browser. |

## Generated and data files

| Path | Contents | Maintained by |
| --- | --- | --- |
| `example-validation-report.md` | Actual validator findings for every catalogued sample from the last container test run. | `scripts/example_report.py`, refreshed by `cda-validator/tests/run-container-tests.sh` |
| `cda-conformance/rules.json`, `pro-conformance/rules.json` | Flat inventory of every Schematron assertion with its ID, context, test, severity, message and MedCom source citation. | `scripts/conformance-rule-inventory.py`; CI fails if stale |
| `cda-conformance/sources.json`, `pro-conformance/sources.json` | Manifest of the MedCom specification PDFs the rules were derived from: URL, SHA-256, retrieval date and SVN revision. | Edited by hand when a specification is re-read |
| `pro-conformance/sample-findings.json` | Audited expected findings for the QFDD and QRD samples, with locations. | Edited by hand |

Do not edit the generated files directly. Regenerate them with the named script.
