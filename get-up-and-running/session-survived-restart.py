#!/usr/bin/env python3
"""Exit successfully if a persisted session can belong to the current engine run.

ITB's status API is backed by its database. An unfinished row and its interaction
can remain after the engine lost its in-memory session during a restart.
"""
import datetime
import json
import sys


def survived(session, engine_started_at):
    if not session.get('startTime'):
        return False
    parse = lambda value: datetime.datetime.fromisoformat(value.replace('Z', '+00:00'))
    # ITB stores second precision, while Docker includes fractional seconds.
    engine_start = parse(engine_started_at).replace(microsecond=0)
    return parse(session['startTime']) >= engine_start


if __name__ == '__main__':
    status = json.load(sys.stdin)
    sessions = status.get('sessions', [])
    raise SystemExit(0 if sessions and survived(sessions[0], sys.argv[1]) else 1)
