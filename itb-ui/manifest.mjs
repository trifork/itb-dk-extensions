import {createHash} from 'node:crypto';
import {readdirSync, readFileSync, writeFileSync} from 'node:fs';
import {join, relative} from 'node:path';

const extension = '/extension';
const assets = '/extension/upstream/gitb-ui/app/assets/build';
const hash = path => createHash('sha256').update(readFileSync(path)).digest('hex');
const files = {};
function inventory(directory) {
  for (const entry of readdirSync(directory, {withFileTypes: true}).sort((a, b) => a.name.localeCompare(b.name))) {
    const path = join(directory, entry.name);
    if (entry.isDirectory()) inventory(path);
    else if (entry.isFile()) files[relative(assets, path)] = hash(path);
  }
}
inventory(assets);
for (const required of ['main.js', 'styles.css', 'polyfills.js', 'scripts.js']) {
  if (!files[required]) throw new Error(`Missing frontend asset: ${required}`);
}
const inputs = {};
for (const name of ['Dockerfile', '.dockerignore', 'upstream.json', 'apply.mjs', 'cda-preview.ts', 'fetch-source.mjs', 'manifest.mjs', 'nginx.conf']) {
  inputs[name] = hash(join(extension, name));
}
writeFileSync(join(extension, 'provenance.json'), JSON.stringify({
  upstream: JSON.parse(readFileSync(join(extension, 'upstream.json'), 'utf8')),
  lockfileSha256: hash('/extension/upstream/gitb-ui/ui/package-lock.json'),
  inputs, files,
}, null, 2) + '\n');
