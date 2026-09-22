#!/usr/bin/env python3
"""Isolated Docker smoke test: real Caddy/Nginx, local TLS CA, synthetic backends."""
import base64
import http.client
import json
import os
from pathlib import Path
import re
import socket
import ssl
import subprocess
import tempfile
import time
import uuid

ROOT = Path(__file__).resolve().parents[1]

BACKEND = '''
import base64, hashlib, json, os
from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer
class Handler(BaseHTTPRequestHandler):
    protocol_version = 'HTTP/1.1'
    def do_GET(self):
        if self.headers.get('Upgrade', '').lower() == 'websocket':
            key = self.headers['Sec-WebSocket-Key'] + '258EAFA5-E914-47DA-95CA-C5AB0DC85B11'
            self.send_response(101)
            self.send_header('Upgrade', 'websocket')
            self.send_header('Connection', 'Upgrade')
            self.send_header('Sec-WebSocket-Accept', base64.b64encode(hashlib.sha1(key.encode()).digest()).decode())
            self.end_headers()
            # Send one unmasked server text frame through both proxies.
            self.wfile.write(bytes([0x81, 2]) + b'ok')
            self.wfile.flush()
            self.close_connection = True
            return
        body = self.rfile.read(int(self.headers.get('Content-Length', 0))).decode()
        data = json.dumps(dict(service=os.environ['SERVICE'], path=self.path,
                               headers=dict(self.headers), body=body)).encode()
        self.send_response(200)
        self.send_header('Content-Type', 'application/json')
        self.send_header('Content-Security-Policy', "connect-src 'self'; frame-ancestors 'none';")
        self.send_header('Content-Length', str(len(data)))
        self.end_headers()
        self.wfile.write(data)
    do_POST = do_GET
    def log_message(self, *args): pass
ThreadingHTTPServer(('0.0.0.0', int(os.environ['PORT'])), Handler).serve_forever()
'''


def docker(*args):
    result = subprocess.run(['docker', *args], cwd=ROOT, text=True, capture_output=True)
    if result.returncode:
        raise RuntimeError(f'Docker {args[0]} failed: {result.stderr}')
    return result.stdout.strip()


def main():
    prefix = 'itb-https-test-' + uuid.uuid4().hex[:12]
    containers = []
    environment = {**os.environ, 'ITB_HTTPS_HOST': 'localhost'}
    config = json.loads(subprocess.check_output([
        'docker', 'compose', '--env-file', '/dev/null', '-f', 'docker-compose.yml',
        '-f', 'get-up-and-running/compose.published.yml',
        '-f', 'get-up-and-running/compose.https.yml', 'config', '--format', 'json',
    ], cwd=ROOT, env=environment, text=True))
    services = config['services']
    for name in ['gitb-ui-gateway', 'gitb-srv', 'cda-validator']:
        assert all(port['host_ip'] == '127.0.0.1' for port in services[name]['ports'])
        assert 'build' not in services[name]
    assert services['gitb-ui']['environment']['TESTBED_HOME_LINK'] == 'https://localhost'
    assert services['gitb-srv']['environment']['CALLBACK_ROOT_URL'] == 'https://localhost/itbsrv'
    assert services['cda-validator']['environment']['SERVER_FORWARD_HEADERS_STRATEGY'] == 'framework'
    nginx_image = re.search(r'^FROM (\S+) AS runtime$',
                            (ROOT / 'itb-ui/Dockerfile').read_text(), re.M)[1]

    def run(name, *args):
        container = prefix + '-' + name
        # Register before starting so failures still clean up created containers.
        containers.append(container)
        docker('run', '-d', '--name', container, '--network', prefix, *args)
        return container

    def port(container, internal):
        return int(docker('port', container, str(internal) + '/tcp').rsplit(':', 1)[1])

    with tempfile.TemporaryDirectory(prefix=prefix) as directory:
        fixture = Path(directory) / 'backend.py'
        fixture.write_text(BACKEND)
        docker('network', 'create', prefix)
        try:
            for name, internal in [('gitb-ui', 9000), ('gitb-srv', 8080), ('cda-validator', 8080)]:
                run(name, '--network-alias', name, '-e', f'SERVICE={name}', '-e', f'PORT={internal}',
                    '-v', f'{fixture}:/backend.py:ro', 'python:3.12.12-slim', 'python', '/backend.py')
            run('gateway', '--network-alias', 'gitb-ui-gateway',
                '-v', f'{ROOT / "itb-ui/nginx.conf"}:/etc/nginx/conf.d/default.conf:ro', nginx_image)
            proxy = run('proxy', '-e', 'ITB_HTTPS_HOST=localhost',
                        '-p', '127.0.0.1::80', '-p', '127.0.0.1::443', '-p', '127.0.0.1::8443',
                        '-v', f'{ROOT / "get-up-and-running/Caddyfile"}:/etc/caddy/Caddyfile:ro',
                        services['https-proxy']['image'])
            root_ca = Path(directory) / 'root.crt'
            for attempt in range(60):
                try:
                    docker('cp', f'{proxy}:/data/caddy/pki/authorities/local/root.crt', str(root_ca))
                    break
                except RuntimeError:
                    if attempt == 59:
                        raise
                    time.sleep(1)
            context = ssl.create_default_context(cafile=str(root_ca))
            ui_port, cda_port = port(proxy, 443), port(proxy, 8443)

            def request(target_port, path, method='GET', body=None, headers=None):
                connection = http.client.HTTPSConnection('localhost', target_port, context=context, timeout=10)
                connection.request(method, path, body=body, headers=headers or {})
                response = connection.getresponse()
                data = response.read()
                connection.close()
                assert response.status == 200, (path, response.status, data)
                return response, json.loads(data)

            connection = http.client.HTTPConnection('localhost', port(proxy, 80), timeout=10)
            connection.request('GET', '/app?test=1', headers={'Host': 'localhost'})
            response = connection.getresponse()
            assert response.status == 308
            assert response.getheader('Location') == 'https://localhost/app?test=1'
            response.read()
            connection.close()

            response, data = request(ui_port, '/api/example?test=1', headers={'X-Forwarded-Proto': 'http'})
            assert data['service'] == 'gitb-ui' and data['path'] == '/api/example?test=1'
            assert data['headers']['X-Forwarded-Proto'] == 'https'
            assert data['headers']['Host'] == f'localhost:{ui_port}'
            assert "frame-src 'self'" in response.getheader('Content-Security-Policy')
            assert "connect-src 'self'" in response.getheader('Content-Security-Policy')
            for path in ['/itbsrv', '/itbsrv/service?wsdl']:
                _, data = request(ui_port, path)
                assert data['service'] == 'gitb-srv' and data['path'] == path
            _, data = request(ui_port, '/itbsrv-other')
            assert data['service'] == 'gitb-ui'
            _, data = request(cda_port, '/api/cda-dk/validation?wsdl')
            assert data['service'] == 'cda-validator'
            assert data['headers']['X-Forwarded-Proto'] == 'https'
            assert data['headers']['Host'] == f'localhost:{cda_port}'

            secret_headers = dict(Cookie='session=test', Authorization='Bearer test', ITB_API_KEY='test',
                                  Origin='https://localhost', Referer='https://localhost/app')
            _, data = request(ui_port, '/cda-preview', 'POST', '<ClinicalDocument/>', secret_headers)
            assert data['service'] == 'cda-validator' and data['path'] == '/cda-dk/preview'
            assert data['body'] == '<ClinicalDocument/>'
            assert not ({key.lower() for key in secret_headers} & {key.lower() for key in data['headers']})

            with context.wrap_socket(socket.create_connection(('localhost', ui_port), timeout=10),
                                     server_hostname='localhost') as websocket:
                key = base64.b64encode(os.urandom(16)).decode()
                websocket.sendall((f'GET /ws HTTP/1.1\r\nHost: localhost:{ui_port}\r\n'
                                   'Upgrade: websocket\r\nConnection: Upgrade\r\n'
                                   f'Sec-WebSocket-Key: {key}\r\nSec-WebSocket-Version: 13\r\n\r\n').encode())
                with websocket.makefile('rb') as stream:
                    assert b'101' in stream.readline()
                    while True:
                        line = stream.readline()
                        assert line, 'WebSocket response ended before the headers completed'
                        if line == b'\r\n':
                            break
                    assert stream.read(4) == b'\x81\x02ok'
            print('PASS: Compose isolation, trusted TLS, HTTP redirect, all backend routes, forwarded HTTPS, CSP, preview sanitisation and WebSocket frame.')
        except Exception:
            for container in containers:
                print(subprocess.run(['docker', 'logs', '--tail', '20', container], capture_output=True, text=True).stderr)
            raise
        finally:
            for container in reversed(containers):
                subprocess.run(['docker', 'rm', '-fv', container], capture_output=True, check=False)
            docker('network', 'rm', prefix)


if __name__ == '__main__':
    main()
