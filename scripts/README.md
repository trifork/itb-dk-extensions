# Maintenance scripts

Repository-level Python tools that generate or read artefacts. They run with `python3 <file>` from the repository root. Sonar tooling for the Java services lives in `xds-service/scripts/`.

| Script | What it does | Used by |
| --- | --- | --- |
| `conformance-rule-inventory.py` | Extracts every Schematron assertion from `cda-validator/domain/cda-dk/sch/versions/*-conformance.sch` into `docs/cda-conformance/rules.json` and `docs/pro-conformance/rules.json`, checking IDs are unique and each rule cites a MedCom source. `--check` fails if the committed files are stale. | `validate-cda.yml` (`--check`), run without flags after editing Schematrons |
| `example_report.py` | Renders the validator's findings for every catalogue sample into `docs/example-validation-report.md` from results saved during a container test run. `--fingerprint <dir>` hashes a staged resource directory so reports can be tied to the exact rules that produced them. | `cda-validator/tests/run-container-tests.sh`, tested by `cda-validator/tests/test_example_report.py` |
| `validator_image.py` | Reads the pinned `isaitb/xml-validator` base image from `docker-compose.yml` (`--print-image`) or queries Docker Hub for the newest stable release and rewrites the pin (`--update`). Never downgrades and requires a manifest digest. | `update-validator-image.yml` (`--update`), `validate-cda.yml`, `publish-images.yml` and `run-container-tests.sh` (`--print-image`), tested by `tests/test_validator_image.py` |

Workflows are in `.github/workflows/`. See `AGENTS.md` for when to run each script locally.
