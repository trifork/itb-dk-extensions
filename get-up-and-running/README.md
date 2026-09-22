# Local ITB bootstrap

Scripts and test definitions that stand up the Interoperability Test Bed (ITB) locally with the CDA validator wired in. The normal entry point is `./get-up-and-running/start.sh` from the repository root. See the root `README.md` for prerequisites, addresses and everyday use, and `docs/xds.md` for the XDS variant.

## Scripts

| File | What it does | Used by |
| --- | --- | --- |
| `start.sh` | Generates the ITB automation master key on first run, pulls published Docker Hub images and starts Compose, waits for readiness, then runs the two setup scripts below. `ITB_ENABLE_XDS=true` adds XDS; `ITB_BUILD_FROM_SOURCE=true` explicitly builds local images. | Users, root `README.md`, `tests/test_startup.py` |
| `compose.published.yml` | Replaces local service images with published Docker Hub images and removes build definitions; supports per-service tag/digest overrides while retaining stock ITB pins and volumes. | `start.sh` by default |
| `setup-itb.sh` | Configures ITB through its REST API: domain, community, specification, actor, the `cdaValidator` service and optionally `xdsConnector`, packages and deploys the release test suite, runs the temporary connection check, and creates or reuses one pending session per release. Saves API keys and session IDs to `.itb-bootstrap.env`. | `start.sh`, `xds-integration.yml` |
| `setup-test-user.sh` | Logs in as the ITB admin, creates the `cda-test@itb` user and its organisation, replaces the one-time password and verifies the release sessions are visible to that user. Saves credentials to `.itb-users.env`. | `start.sh`, `xds-integration.yml` |
| `reset.sh` | Removes containers, volumes, test history and all generated `.itb*.env` files, then runs `start.sh`. Destructive by design. | Developers only |
| `package-test-suite.sh` | Zips `test-suite/` or `setup-check/` into an ITB test suite archive. With `ITB_ENABLE_XDS=true` it calls `enable-xds.py` on the upload suite first. | `setup-itb.sh`, `tests/test_xds_packaging.py` |
| `enable-xds.py` | Inserts the shared flow from `xds-flow.xml` into every staged release test so the user can choose between local upload and XDS retrieval. Preserves test case IDs. | `package-test-suite.sh` |
| `session_catalogue.py` | Maps each release in `rulesets.json` to its deployed test case index and a durable session variable name such as `ITB_PHMR_1_3_SESSION_ID`. | `setup-itb.sh`, `setup-test-user.sh`, `tests/test_session_catalogue.py` |
| `session-survived-restart.py` | Decides whether a pending session recorded in the ITB database predates the current engine start and must be replaced. | `setup-itb.sh`, `tests/test_xds_packaging.py` |

## Test definitions

| Path | Contents |
| --- | --- |
| `test-suite/` | The deployed GITB Test Description Language (TDL) suite: one manual upload test per registered release. `tests/check-rulesets.py` enforces the one-to-one mapping. |
| `setup-check/` | A temporary automated suite that validates a bundled PHMR sample to prove ITB can reach the validator. Deployed, run and removed during setup. |
| `xds-flow.xml` | The TDL steps spliced into each release test when XDS is enabled: source choice, registry selection, DDS search and retrieval with error guards. |

## Generated state

`.itb.env`, `.itb-bootstrap.env`, `.itb-users.env` and `build/` are created by the scripts, hold credentials and session IDs, and are git-ignored. Delete them only through `reset.sh`.
