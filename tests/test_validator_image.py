#!/usr/bin/env python3
import io
import json
from pathlib import Path
import sys
import unittest
from unittest.mock import patch

sys.path.insert(0, str(Path(__file__).resolve().parents[1] / 'scripts'))
import validator_image as image


def tag(name, digest='b'):
    return {'name': name, 'digest': 'sha256:' + digest * 64}


class ImageUpdates(unittest.TestCase):
    def setUp(self):
        self.compose = ('services:\n  cda-validator:\n    image: itb-dk-cda:local\n'
                        '    build:\n      context: ./cda-validator\n      args:\n'
                        '        CDA_VALIDATOR_IMAGE: isaitb/xml-validator:1.9.0@sha256:'
                        + 'a' * 64 + '\n  db:\n    image: mysql:8\n')

    def test_numeric_order_and_stable_tags_only(self):
        tags = [tag('latest'), tag('2.0.0-rc1'), tag('1.9.0'), tag('1.10.0')]
        updated, result = image.propose_update(self.compose, tags)
        self.assertTrue(result['changed'])
        self.assertEqual(result['version'], '1.10.0')
        self.assertIn('image: mysql:8', updated)
        self.assertIn('image: itb-dk-cda:local', updated)
        self.assertEqual(image.read_pin(updated)['image'], result['image'])
        self.assertEqual(image.propose_update(updated, tags)[0], updated)
        self.assertFalse(image.propose_update(updated, tags)[1]['changed'])

    def test_no_downgrade_or_automatic_retag(self):
        for tags in ([tag('1.8.0')], [tag('1.9.0')]):
            updated, result = image.propose_update(self.compose, tags)
            self.assertFalse(result['changed'])
            self.assertEqual(updated, self.compose)

    def test_missing_or_invalid_data_fails(self):
        for tags in ([], [tag('latest')], [{'name': '2.0.0', 'digest': None}]):
            with self.assertRaises(ValueError):
                image.propose_update(self.compose, tags)
        for content in ('CDA_VALIDATOR_IMAGE: isaitb/xml-validator:latest',
                        'image: isaitb/xml-validator:1.9.0@sha256:' + 'a' * 64,
                        self.compose + self.compose):
            with self.assertRaises(ValueError):
                image.read_pin(content)

    def test_follows_all_pages(self):
        pages = [dict(results=[tag('1.9.0')], next=image.TAGS_URL + '?page=2'),
                 dict(results=[tag('1.10.0')], next=None)]
        with patch.object(image.urllib.request, 'urlopen', side_effect=[io.BytesIO(json.dumps(p).encode()) for p in pages]) as request:
            self.assertEqual(image.latest_release(image.fetch_tags())['name'], '1.10.0')
            self.assertEqual(request.call_count, 2)

    def test_rejects_untrusted_pagination(self):
        page = dict(results=[], next='https://example.com/tags')
        with patch.object(image.urllib.request, 'urlopen', return_value=io.BytesIO(json.dumps(page).encode())):
            with self.assertRaises(ValueError):
                list(image.fetch_tags())


if __name__ == '__main__':
    unittest.main()
