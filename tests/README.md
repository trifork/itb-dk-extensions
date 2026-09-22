# Repository checks

Python checks of the repository's configuration and packaging, run with `python3 <file>`. Only `test_https_proxy.py` needs Docker and image pulls; other checks need no Docker or network. Container-level tests of the validator itself live in `cda-validator/tests/`.

| Script | What it checks | Run by |
| --- | --- | --- |
| `check-rulesets.py` | The release catalogue in `cda-validator/domain/cda-dk/rulesets.json` matches `config.properties`, the schema and schematron files exist, every sample has an expected result and unchanged SHA-256, and the ITB suite has exactly one pinned upload test per release. | `validate-cda.yml`, `xds-integration.yml` |
| `test_validator_image.py` | The logic in `scripts/validator_image.py` that proposes bumps of the pinned `isaitb/xml-validator` image: stable-only ordering, no downgrades, digest validation, safe Docker Hub pagination. Uses mocked responses. | `update-validator-image.yml` (gate before the real update), `validate-cda.yml` |
| `test_xds_packaging.py` | `get-up-and-running/package-test-suite.sh` produces equivalent suites with XDS on and off, the XDS steps carry the expected connector, dropdowns, registry selection and error guards, and the setup-check suite never depends on XDS. | `xds-integration.yml` |
| `test_session_catalogue.py` | `get-up-and-running/session_catalogue.py` maps releases to ITB session variables, keeps legacy slot names, derives variables for new releases and rejects releases missing from the suite. | `xds-integration.yml` |
| `test_startup.py` | Runs bootstrap with fake Docker/HTTP/setup commands to check published-image pulls, source builds, optional XDS/HTTPS, hostname validation, local readiness, failure without fallback and preservation of saved configuration. | `validate-cda.yml`, `xds-integration.yml` |
| `test_https_proxy.py` | Runs isolated Caddy/Nginx containers with a trusted local CA and synthetic backends to verify HTTPS routing, redirects, HTTPS-only HSTS including error responses and upstream overrides, forwarded headers, CSP/nonce preservation, WebSocket frames, preview credential stripping and loopback-only Compose mappings; removes only its own test containers/network. | `xds-integration.yml`, developers with Docker |

Workflows are in `.github/workflows/`. See `AGENTS.md` for the full local check sequence.
