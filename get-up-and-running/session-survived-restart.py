#!/usr/bin/env python3
"""Exit successfully if a persisted session can belong to the current engine run.

ITB's status API is backed by its database. An unfinished row and its interaction
can remain after the engine lost its in-memory session during a restart.
"""
import datetime
import json
import sys


def parse_timestamp(value):
    try:
        parsed = datetime.datetime.fromisoformat(value.replace('Z', '+00:00'))
    except ValueError:
        # ITB 1.30.2's status API uses its default display format. The stock
        # Compose deployment uses UTC; never interpret this in the host's zone.
        parsed = datetime.datetime.strptime(value, '%d/%m/%Y %H:%M:%S')
    if parsed.tzinfo is None:
        parsed = parsed.replace(tzinfo=datetime.timezone.utc)
    return parsed


def survived(session, engine_started_at):
    if not session.get('startTime'):
        return False
    try:
        # ITB stores second precision, while Docker includes fractional seconds.
        engine_start = parse_timestamp(engine_started_at).replace(microsecond=0)
        return parse_timestamp(session['startTime']) >= engine_start
    except (ValueError, TypeError, AttributeError):
        # Missing or unrecognised timestamps cannot establish a live session.
        return False


if __name__ == '__main__':
    status = json.load(sys.stdin)
    sessions = status.get('sessions', [])
    raise SystemExit(0 if sessions and survived(sessions[0], sys.argv[1]) else 1)
