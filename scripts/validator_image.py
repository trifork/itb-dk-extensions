#!/usr/bin/env python3
"""Read the Compose image pin or propose the newest stable Docker Hub release."""
import argparse
import json
import re
import urllib.request
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
TAGS_URL = 'https://hub.docker.com/v2/repositories/isaitb/xml-validator/tags'
VERSION = re.compile(r'(0|[1-9][0-9]*)\.(0|[1-9][0-9]*)\.(0|[1-9][0-9]*)')
DIGEST = re.compile(r'sha256:[0-9a-f]{64}')
PIN = re.compile(
    r'^\s*CDA_VALIDATOR_IMAGE: (?P<image>isaitb/xml-validator:(?P<version>[0-9]+\.[0-9]+\.[0-9]+)'
    r'@sha256:[0-9a-f]{64})[ \t]*$', re.MULTILINE)


def read_pin(content):
    matches = list(PIN.finditer(content))
    if len(matches) != 1:
        raise ValueError('Expected exactly one CDA_VALIDATOR_IMAGE version-and-digest build argument in Compose')
    return matches[0]


def version_key(version):
    match = VERSION.fullmatch(version)
    if not match:
        raise ValueError(f'Invalid stable version: {version}')
    return tuple(map(int, match.groups()))


def fetch_tags():
    url = TAGS_URL + '?page_size=100'
    seen = set()
    while url:
        if not url.startswith(TAGS_URL + '?') or url in seen:
            raise ValueError('Invalid or repeated Docker Hub pagination URL')
        seen.add(url)
        request = urllib.request.Request(url, headers={'Accept': 'application/json',
                                                      'User-Agent': 'cda-validator-image-updater'})
        with urllib.request.urlopen(request, timeout=30) as response:
            page = json.load(response)
        yield from page['results']
        url = page.get('next')


def latest_release(tags):
    stable = [tag for tag in tags if VERSION.fullmatch(tag['name'])]
    if not stable:
        raise ValueError('Docker Hub returned no stable release tags')
    newest = max(stable, key=lambda tag: version_key(tag['name']))
    if not DIGEST.fullmatch(newest.get('digest') or ''):
        raise ValueError('Newest stable Docker Hub release has no valid manifest digest')
    return newest


def propose_update(content, tags):
    pin = read_pin(content)
    release = latest_release(tags)
    changed = version_key(release['name']) > version_key(pin['version'])
    image = f"isaitb/xml-validator:{release['name']}@{release['digest']}" if changed else pin['image']
    result = dict(changed=changed, old_image=pin['image'], image=image,
                  version=release['name'] if changed else pin['version'])
    # Update only the base-image build argument, preserving the local image tag.
    updated = content[:pin.start('image')] + image + content[pin.end('image'):]
    return updated, result


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--print-image', action='store_true', help='Print the local pin without network access')
    parser.add_argument('--update', action='store_true', help='Write a newer release pin to Compose')
    parser.add_argument('--github-output', type=Path)
    args = parser.parse_args()
    compose = ROOT / 'docker-compose.yml'
    content = compose.read_text()
    if args.print_image:
        print(read_pin(content)['image'])
        return
    updated, result = propose_update(content, fetch_tags())
    if args.update and result['changed']:
        compose.write_text(updated)
    if args.github_output:
        with args.github_output.open('a') as output:
            for key, value in result.items():
                output.write(f'{key}={str(value).lower() if isinstance(value, bool) else value}\n')
    print(json.dumps(result, indent=2))


if __name__ == '__main__':
    main()
