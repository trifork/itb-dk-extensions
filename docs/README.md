# Documentation

Reference material for the Danish CDA validator and its ITB integration. The root `README.md` covers setup and everyday use. `AGENTS.md` lists which of these to read before changing what.

## Guides

| Document | Covers |
| --- | --- |
| `versioning.md` | How profile releases are named and selected in the validator, REST, SOAP and ITB tests, and how to add or retire a release. |
| `cda-conformance.md` | Source-derived Schematron checks for the CDA profiles (APD, CPD, PDC, PHMR, PHAD, PMR, PRF, PSCR): coverage, element-specific finding locations, Gazelle finding severity and regression checks, specification conflicts and deliberate gaps. |
| `pro-conformance.md` | The same for the PRO profiles QFDD-DK 1.2 and QRD-DK 1.3.2. |
| `xds.md` | Enabling and configuring the optional IHE XDS integration for finding CDA documents in the Danish Document Sharing Service (DDS): credentials and vault password, separate HSUID healthcare organisation identifier/scheme and MedCom test default, DDS/SFSK TEST1/TEST2 endpoints and whitelisting, verified FOCES test-patient retrievals, browser validation outcomes and explicit batch continuation after failure, bounded SOAP fault and correlation details in user-facing errors, diagnostic settings, route-specific Stamkort forms with valid FOCES defaults and DDS MOCES defaults, system authentication and employee access failures, stable/on-demand selection and saved home-community retrieval, UTC year-to-second precision pickers, verified Else/QRD precision searches and REST DTM bounds, metadata search catalogues and per-type coding schemes, repository labels, Docker Hub startup/publication, verification and troubleshooting. |
| `xds-service.md` | Bounded user-facing SOAP fault diagnostics; native IPF partial-date processing and compatible REST DTM bounds; architecture, home-community propagation and entry-type selection in the REST/SOAP contracts of the Java `xds-service` that backs the XDS integration; explicit SFSK capabilities and system-ID-card propagation, automated/browser coverage and its distinction from documented live SFSK diagnostics. |
| `dependency-review.md` | Point-in-time review of Maven dependency and plugin versions in both Java projects, dated 17 September 2026, with Gazelle access/versions rechecked on 19 September and anonymous resolution through Trifork's IHE Nexus proxy documented on 22 September. |
| `cda-validation-slides.html` | Standalone slide deck with a business-level progress overview. Open in a browser. |

## Generated and data files

| Path | Contents | Maintained by |
| --- | --- | --- |
| `example-validation-report.md` | Actual validator findings for every catalogued sample from the last container test run. | `scripts/example_report.py`, refreshed by `cda-validator/tests/run-container-tests.sh` |
| `cda-conformance/rules.json`, `pro-conformance/rules.json` | Flat inventory of every Schematron assertion with its ID, element-specific reporting context, test, severity, message and MedCom source citation. | `scripts/conformance-rule-inventory.py`; CI fails if stale |
| `cda-conformance/sources.json`, `pro-conformance/sources.json` | Manifest of the MedCom specification PDFs the rules were derived from: URL, SHA-256, retrieval date and SVN revision. | Edited by hand when a specification is re-read |
| `pro-conformance/sample-findings.json` | Audited expected findings for the QFDD and QRD samples, with locations checked against the validator image. | Edited by hand |

Do not edit the generated files directly. Regenerate them with the named script.
