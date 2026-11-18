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

# nginx 1.30.7 fixes the resolver use-after-free and other advisories (nginx.org, 2026-11-18). Its
# nginxinc/nginx-unprivileged image is not published yet, so apply the same unprivileged changes to the
# official image: no user directive, pid and temp paths under /tmp, config and cache owned by uid 101.
# Move back to nginx-unprivileged once it publishes the same nginx release.
# The release tag accompanies the immutable digest so Docker DX identifies the correct image variant.
FROM nginx:1.30.7-alpine-slim@sha256:e00f38ab6677f5a8d861a9d9430f97c491a44f98072aa349915e4abb7e7f432b AS gateway-base
RUN sed -i -e '/^user /d' -e 's,/run/nginx.pid,/tmp/nginx.pid,' /etc/nginx/nginx.conf \
 && sed -i '/^http {/a\    proxy_temp_path /tmp/proxy_temp;\n    client_body_temp_path /tmp/client_temp;\n    fastcgi_temp_path /tmp/fastcgi_temp;\n    uwsgi_temp_path /tmp/uwsgi_temp;\n    scgi_temp_path /tmp/scgi_temp;\n' /etc/nginx/nginx.conf \
 && chown -R 101:0 /etc/nginx /var/cache/nginx \
 && chmod -R g+w /etc/nginx /var/cache/nginx

FROM gateway-base AS runtime
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=frontend /extension/upstream/gitb-ui/app/assets/build/ /usr/share/nginx/itb-assets/
COPY --from=frontend /extension/provenance.json /usr/share/nginx/itb-extension/provenance.json
COPY --from=frontend /extension/notices/ /usr/share/doc/itb-extension/
USER 101:101
