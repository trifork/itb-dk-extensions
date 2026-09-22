# Repository checks

Fast Python checks of the repository's configuration and packaging. They need no Docker or network and run with `python3 <file>`. Container-level tests of the validator itself live in `cda-validator/tests/`.

| Script | What it checks | Run by |
| --- | --- | --- |
| `check-rulesets.py` | The release catalogue in `cda-validator/domain/cda-dk/rulesets.json` matches `config.properties`, the schema and schematron files exist, every sample has an expected result and unchanged SHA-256, and the ITB suite has exactly one pinned upload test per release. | `validate-cda.yml`, `xds-integration.yml` |
| `test_validator_image.py` | The logic in `scripts/validator_image.py` that proposes bumps of the pinned `isaitb/xml-validator` image: stable-only ordering, no downgrades, digest validation, safe Docker Hub pagination. Uses mocked responses. | `update-validator-image.yml` (gate before the real update), `validate-cda.yml` |
| `test_xds_packaging.py` | `get-up-and-running/package-test-suite.sh` produces equivalent suites with XDS on and off, the XDS steps carry the expected connector, dropdowns, registry selection and error guards, and the setup-check suite never depends on XDS. | `xds-integration.yml` |
| `test_session_catalogue.py` | `get-up-and-running/session_catalogue.py` maps releases to ITB session variables, keeps legacy slot names, derives variables for new releases and rejects releases missing from the suite. | `xds-integration.yml` |

Workflows are in `.github/workflows/`. See `AGENTS.md` for the full local check sequence.
