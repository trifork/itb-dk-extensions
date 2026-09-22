#!/usr/bin/env python3
"""Install the pinned, checksum-verified Sonar Java analyzers without an IDE/server."""
import hashlib
import json
from pathlib import Path
import shutil
import tempfile
import urllib.request
import zipfile

ROOT = Path(__file__).resolve().parents[1]
PIN = json.loads((ROOT / 'scripts/sonar-analyzer.json').read_text())
DESTINATION = ROOT / 'target/sonar-analyzer'


def install():
    DESTINATION.mkdir(parents=True, exist_ok=True)
    with tempfile.TemporaryDirectory(prefix='xds-sonar-') as directory:
        archive = Path(directory) / 'analyzer.vsix'
        digest = hashlib.sha256()
        with urllib.request.urlopen(PIN['url'], timeout=60) as response, archive.open('wb') as output:
            while chunk := response.read(1024 * 1024):
                digest.update(chunk)
                output.write(chunk)
        if digest.hexdigest() != PIN['sha256']:
            raise ValueError('Sonar analyzer checksum mismatch')
        with zipfile.ZipFile(archive) as package:
            for name in ('server/sonarlint-ls.jar', 'analyzers/sonarjava.jar',
                         'analyzers/sonarjavasymbolicexecution.jar'):
                target = DESTINATION / name
                target.parent.mkdir(parents=True, exist_ok=True)
                with package.open('extension/' + name) as source, target.open('wb') as output:
                    shutil.copyfileobj(source, output)
    print(f"Installed Sonar Java analyzers from SonarQube for IDE {PIN['version']} (SHA-256 verified)")
    print(DESTINATION)


if __name__ == '__main__':
    install()
