# CDA preview in ITB reports

**View CDA** beside an XML attachment renders its header and narrative through
`/cda-preview`. Preview preserves original bytes and validation findings;
structured questionnaire fields may not appear.

Validation reports show **Click an error or warning for more details** above
selectable findings when errors or warnings are visible.

Interaction dialogs keep their title and action buttons inside the viewport while
long forms scroll internally. Opening and closing an interaction has no slide/fade
animation, and initial text-field focus does not scroll the dialog. This applies to
both running tests and pending interactions opened from session history.

DDS service start/stop filters offer Year, Month, Day, Hour, Minute and Second
precision, using calendar/time controls where supported by the browser. Year uses
a four-digit field; hour precision requires minutes `00`. Changing precision clears
the value to avoid silently changing a boundary. TDL text requests opt in with
`mimeType="text/plain;format=date-time;timezone=UTC"`. Clock values are UTC without
browser timezone conversion. Submission retains partial dates, adds `Z` to full
second timestamps, preserves empty bounds and checks native validity. Other text
fields keep their normal behaviour.

Batch execution keeps a failed or stopped test visible, including its session ID,
log and reports. **Start next test** explicitly prepares and starts the next
selected test. **Continue automatically** applies only after success; disabling
it also pauses between successful tests. This prevents a failed search from
immediately disappearing behind a new test's document-source form.

## Build and load

The gateway downloads the checksum-pinned ITB release source in `upstream.json`,
adds the preview control to the Angular component and template, then runs `npm ci`
and the upstream production build. The TypeScript extension is compiled together
with ITB. Stock ITB images remain unchanged.

Compose passes its `gitb-ui` image pin to the build using a YAML anchor. The build
rejects a mismatch with the reviewed source/image pair in `upstream.json`.
Update both pins together when upgrading ITB. The reviewed pair currently uses
ITB 1.30.2, including its fixes for multi-select interactions.

`get-up-and-running/start.sh` pulls the published gateway from Docker Hub.
Use `ITB_BUILD_FROM_SOURCE=true` to build the checkout instead. To build and update
only the gateway during development:

```bash
docker compose --env-file get-up-and-running/.itb.env up -d --build --no-deps gitb-ui-gateway
```

Reload the browser after deployment. No host asset preparation is needed.
The gateway serves `/assets/build/`, preserves ITB APIs and WebSockets, and
forwards `/cda-preview` to the CDA renderer on the same origin. ITB API keys,
cookies and authorization headers are stripped from renderer requests.
The optional HTTPS Compose overlay terminates TLS in Caddy; the gateway preserves
its HTTPS forwarding header for ITB while retaining WebSocket upgrades. Its HTTP
host port is loopback-only in that configuration. See the root README for setup.

## Provenance and verification

The image records the upstream source/image pins, npm lockfile hash, extension
input hashes and served asset hashes at `/itb-extension/provenance.json`.
Upstream licence notices are copied from the verified source archive, and Angular
includes third-party notices with its compiled assets.
The frontend is part of [ISAITB/gitb](https://github.com/ISAITB/gitb), licensed EUPL.
The Nginx runtime runs as UID 101. Its tag accompanies the immutable digest so
Docker DX identifies the correct image variant; Sonar S8431 prefers only one.

```bash
cd itb-ui
npm ci
npx playwright install chromium
ITB_PREVIEW_TEST_URL=http://localhost:9000 \
CDA_PREVIEW_TEST_URL=http://localhost:8091/cda-dk/preview npm test
```

Docker provides Node for the frontend build; host Node 24+ is only needed for
browser tests. Tests cover provenance, served assets, startup, CSP, original bytes
and preview behaviour. `tests/interactions.spec.js` additionally signs in with the
provisioned test user, creates its own synthetic sessions and verifies DDS/SFSK
identity defaults and form submission through retrieval and validation. It uses `ITB_STATE_FILE` and
`ITB_USER_STATE_FILE` when set, otherwise the ignored bootstrap/user state files.
The batch regression also exercises the live execution page: invalid CPR fails
locally, the failed session remains visible, and only **Start next test** creates
the next session. Run the complete file against the isolated fixture stack, not
a live NSP backend. Date-picker regressions verify all six precisions, UTC submission, invalid years,
clearing and reset in Copenhagen and New York browser timezones; they reject the
CPR locally before any NSP query. Review the source extension and verify real report
attachments when upgrading ITB.

Successful default-branch XDS integration publishes
`docker.io/trifork/itb-dk-extensions-itb-ui:sha-<full-commit-SHA>` for amd64/arm64,
with build provenance and SBOM attestations. `latest` advances only for the
current default-branch head. The publisher reads the UI pin from Compose too.

To remove the extension, stop/remove the gateway and restore port `9000:9000` on
`gitb-ui`, then recreate that service. Preserve all data volumes.
