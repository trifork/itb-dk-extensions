import {createHash} from 'node:crypto';
import {execFileSync} from 'node:child_process';
import {copyFileSync, mkdirSync, readFileSync, readdirSync, unlinkSync, writeFileSync} from 'node:fs';
import {dirname, join} from 'node:path';
import {fileURLToPath} from 'node:url';
import {gunzipSync} from 'node:zlib';

const here = dirname(fileURLToPath(import.meta.url));
const upstream = JSON.parse(readFileSync(join(here, 'upstream.json'), 'utf8'));
if (process.env.ITB_UI_IMAGE !== upstream.image) {
  throw new Error('Review and update upstream.json to match the Compose ITB UI image before building');
}
const response = await fetch(`https://github.com/ISAITB/gitb/archive/${upstream.commit}.tar.gz`, {
  signal: AbortSignal.timeout(120000)
});
if (!response.ok) throw new Error(`Upstream source download failed: HTTP ${response.status}`);
const bytes = Buffer.from(await response.arrayBuffer());
if (createHash('sha256').update(bytes).digest('hex') !== upstream.archiveSha256) {
  throw new Error('Upstream archive checksum mismatch');
}
const archive = join(here, 'source.tar');
const source = join(here, 'upstream');
writeFileSync(archive, gunzipSync(bytes));
mkdirSync(source);
execFileSync('tar', ['--extract', '--file', archive, '--directory', source,
  '--strip-components=1', '--no-same-owner', '--no-same-permissions'], {stdio: 'inherit'});
execFileSync(process.execPath, [join(here, 'apply.mjs'), join(source, 'gitb-ui/ui')], {stdio: 'inherit'});
const notices = join(here, 'notices');
mkdirSync(notices);
for (const entry of readdirSync(source, {withFileTypes: true})) {
  if (entry.isFile() && /^(license|licence|notice)/i.test(entry.name)) {
    copyFileSync(join(source, entry.name), join(notices, entry.name));
  }
}
unlinkSync(archive);
