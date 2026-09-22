#!/usr/bin/env python3
"""Exercise bootstrap image selection without starting Docker or touching local state."""
import json
import os
from pathlib import Path
import shutil
import subprocess
import sys
import tempfile
import unittest

ROOT = Path(__file__).resolve().parents[1]


class Startup(unittest.TestCase):
    def setUp(self):
        self.directory = tempfile.TemporaryDirectory()
        self.addCleanup(self.directory.cleanup)
        self.root = Path(self.directory.name)
        self.bootstrap = self.root / 'get-up-and-running'
        self.bootstrap.mkdir()
        shutil.copy2(ROOT / 'get-up-and-running/start.sh', self.bootstrap / 'start.sh')
        self.state = self.bootstrap / '.itb.env'
        self.state.write_text('ITB_AUTOMATION_API_MASTER_KEY=existing-test-key\n')
        self.state.chmod(0o600)
        self.initial_state = self.state.read_bytes()
        self.calls = self.root / 'calls.jsonl'
        self.bin = self.root / 'bin'
        self.bin.mkdir()
        fake = f'''#!{sys.executable}
import json, os, sys
from pathlib import Path
name = Path(sys.argv[0]).name
with open(os.environ['STARTUP_TEST_CALLS'], 'a') as output:
    output.write(json.dumps([name, *sys.argv[1:]]) + '\\n')
if name == 'docker':
    sys.exit(int(os.environ.get('STARTUP_TEST_DOCKER_STATUS', '0')))
'''
        for path in [self.bin / 'docker', self.bin / 'curl',
                     self.bootstrap / 'setup-itb.sh', self.bootstrap / 'setup-test-user.sh']:
            path.write_text(fake)
            path.chmod(0o755)
        self.env = {
            key: value for key, value in os.environ.items()
            if not key.startswith(('ITB_', 'COMPOSE_', 'CDA_', 'XDS_'))
        }
        self.env.update(PATH=str(self.bin) + os.pathsep + os.environ['PATH'],
                        STARTUP_TEST_CALLS=str(self.calls))

    def run_start(self, **settings):
        result = subprocess.run(
            ['bash', str(self.bootstrap / 'start.sh')], cwd=self.root,
            env={**self.env, **settings}, capture_output=True, text=True)
        calls = [json.loads(line) for line in self.calls.read_text().splitlines()] if self.calls.exists() else []
        self.assertEqual(self.initial_state, self.state.read_bytes())
        self.assertNotIn('existing-test-key', result.stdout + result.stderr)
        return result, calls

    def test_default_pulls_images_and_completes_setup(self):
        result, calls = self.run_start()
        self.assertEqual(0, result.returncode, result.stderr)
        docker = calls[0]
        self.assertEqual(['docker', 'compose'], docker[:2])
        self.assertIn(str(self.bootstrap / 'compose.published.yml'), docker)
        self.assertIn('--no-build', docker)
        self.assertEqual('always', docker[docker.index('--pull') + 1])
        self.assertNotIn('--build', docker)
        self.assertNotIn('--profile', docker)
        self.assertEqual(['setup-itb.sh', 'setup-test-user.sh'], [call[0] for call in calls[-2:]])

    def test_xds_uses_published_images_and_waits_for_readiness(self):
        result, calls = self.run_start(ITB_ENABLE_XDS='true')
        self.assertEqual(0, result.returncode, result.stderr)
        docker = calls[0]
        self.assertEqual('xds', docker[docker.index('--profile') + 1])
        self.assertIn('--no-build', docker)
        self.assertIn('--wait', docker)

    def test_source_build_is_explicit(self):
        result, calls = self.run_start(ITB_BUILD_FROM_SOURCE='true')
        self.assertEqual(0, result.returncode, result.stderr)
        docker = calls[0]
        self.assertIn('--build', docker)
        self.assertNotIn('--no-build', docker)
        self.assertNotIn('--pull', docker)
        self.assertNotIn(str(self.bootstrap / 'compose.published.yml'), docker)

    def test_failed_pull_stops_without_build_or_setup(self):
        result, calls = self.run_start(STARTUP_TEST_DOCKER_STATUS='23')
        self.assertEqual(23, result.returncode)
        self.assertEqual(1, len(calls))
        self.assertIn('--no-build', calls[0])
        self.assertNotIn('--build', calls[0])

    def test_invalid_build_mode_stops_before_docker(self):
        result, calls = self.run_start(ITB_BUILD_FROM_SOURCE='yes')
        self.assertNotEqual(0, result.returncode)
        self.assertIn('ITB_BUILD_FROM_SOURCE must be true or false', result.stderr)
        self.assertEqual([], calls)

    def test_saved_source_build_preference_is_respected(self):
        with self.state.open('a') as output:
            output.write('ITB_BUILD_FROM_SOURCE=true\n')
        self.initial_state = self.state.read_bytes()
        result, calls = self.run_start()
        self.assertEqual(0, result.returncode, result.stderr)
        self.assertIn('--build', calls[0])


if __name__ == '__main__':
    unittest.main()
