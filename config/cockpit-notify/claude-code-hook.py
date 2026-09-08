#!/usr/bin/env python3
"""Claude Code hook -> cockpit notification card (2026-09-08).

Wired for Notification (Claude needs you: permission, idle question) and Stop
(a turn finished). Reads the hook JSON on stdin, never blocks the session:
anything that fails is swallowed, exit 0 always.

Stop cards are low urgency and share one group per session, so a long session
replaces its own card instead of stacking six. Notification cards stay until
dismissed; a click on any card focuses the Claude window.
"""
import json
import os
import subprocess
import sys


def main() -> int:
    try:
        payload = json.load(sys.stdin)
    except Exception:
        payload = {}
    event = payload.get("hook_event_name", "")
    cwd = payload.get("cwd") or os.getcwd()
    proj = os.path.basename(cwd.rstrip("/")) or cwd
    sid = (payload.get("session_id") or "")[:8]
    if event == "Notification":
        msg = payload.get("message") or payload.get("title") or "Claude needs you"
        args = ["--kind", "info", "--urgency", "normal", "--title", f"{proj}: Claude needs you", "--body", msg,
                "--timeout", "0", "--group", f"claude-code:{sid}"]
    elif event == "Stop":
        if payload.get("stop_hook_active"):
            return 0
        args = ["--kind", "done", "--urgency", "low", "--title", f"{proj}: turn finished",
                "--body", "Click to focus Claude", "--group", f"claude-code:{sid}"]
    else:
        return 0
    try:
        subprocess.Popen([os.path.expanduser("~/.local/bin/cockpit-notify"), "--source", "claude-code", *args],
                         stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL, start_new_session=True)
    except Exception:
        pass
    return 0


if __name__ == "__main__":
    sys.exit(main())
