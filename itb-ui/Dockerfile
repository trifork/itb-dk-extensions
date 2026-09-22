# Docker Hardened Node 24 dev; pinned multi-platform digest.
FROM --platform=$BUILDPLATFORM dhi.io/node@sha256:ad73bb38988052d9c17677cceaa4eb134d6c9132a84c08770e1a0162d02d1a03 AS frontend
RUN mkdir /extension && chown 65532:65532 /extension
WORKDIR /extension
COPY --chown=65532:65532 . .
ENV NODE_OPTIONS=--max-old-space-size=4096 HOME=/extension
USER 65532:65532
ARG ITB_UI_IMAGE
RUN node fetch-source.mjs
WORKDIR /extension/upstream/gitb-ui/ui
RUN npm ci --no-audit --no-fund && npm run build:prod
RUN node /extension/manifest.mjs

# Keep the release tag with the digest: Docker DX otherwise reports latest's CVEs.
FROM nginxinc/nginx-unprivileged:1.30.5-alpine-slim@sha256:c2c3905bda3dc8de80023e19bed0a45745279d26e5586cdee64370c8f9b12348 AS runtime
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=frontend /extension/upstream/gitb-ui/app/assets/build/ /usr/share/nginx/itb-assets/
COPY --from=frontend /extension/provenance.json /usr/share/nginx/itb-extension/provenance.json
COPY --from=frontend /extension/notices/ /usr/share/doc/itb-extension/
USER 101:101
