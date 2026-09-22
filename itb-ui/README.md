# CDA preview in ITB reports

**View CDA** beside an XML attachment renders its header and narrative through
`/cda-preview`. Preview preserves original bytes and validation findings;
structured questionnaire fields may not appear.

## Build and load

The gateway downloads the checksum-pinned ITB release source in `upstream.json`,
adds the preview control to the Angular component and template, then runs `npm ci`
and the upstream production build. The TypeScript extension is compiled together
with ITB. Stock ITB images remain unchanged.

Compose passes its `gitb-ui` image pin to the build using a YAML anchor. The build
rejects a mismatch with the reviewed source/image pair in `upstream.json`.
Update both pins together when upgrading ITB.

`get-up-and-running/start.sh` builds the gateway. To update only the gateway:

```bash
docker compose --env-file get-up-and-running/.itb.env up -d --build --no-deps gitb-ui-gateway
```

Reload the browser after deployment. No host asset preparation is needed.
The gateway serves `/assets/build/`, preserves ITB APIs and WebSockets, and
forwards `/cda-preview` to the CDA renderer on the same origin. ITB API keys,
cookies and authorization headers are stripped from renderer requests.

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
and preview behaviour. Review the source extension and verify real report
attachments when upgrading ITB.

Successful default-branch XDS integration publishes
`docker.io/trifork/itb-dk-extensions-itb-ui:sha-<full-commit-SHA>` for amd64/arm64,
with build provenance and SBOM attestations. `latest` advances only for the
current default-branch head. The publisher reads the UI pin from Compose too.

To remove the extension, stop/remove the gateway and restore port `9000:9000` on
`gitb-ui`, then recreate that service. Preserve all data volumes.
