#!/usr/bin/env python3
"""Show loopback development servers in Waybar and open one safely on click."""
import json
import shutil
import subprocess
import sys

DEV_MARKERS = (
    "vite", "next", "webpack", "nuxt", "astro", "remix", "tsx", "nodemon",
    "parcel", "gatsby", "storybook", "http-server", "live-server", "svelte",
    "react-scripts", "ng serve", "wrangler",
)
LOOPBACK_HOSTS = {"127.0.0.1", "::1", "[::1]", "0.0.0.0", "*", "[::]"}


def servers():
    try:
        output = subprocess.run(
            ["ss", "-tlnpH"], text=True, capture_output=True, timeout=2, check=False
        ).stdout
    except (OSError, subprocess.SubprocessError):
        return []

    found = set()
    for line in output.splitlines():
        fields = line.split()
        if len(fields) < 5:
            continue
        host, separator, port = fields[3].rpartition(":")
        command = line.lower()
        if (
            separator
            and host in LOOPBACK_HOSTS
            and port.isdigit()
            and any(marker in command for marker in DEV_MARKERS)
        ):
            found.add(int(port))
    return sorted(found)


def open_server(ports):
    if not ports:
        return
    choices = [f"http://localhost:{port}" for port in ports]
    target = choices[0]
    if len(choices) > 1 and shutil.which("wofi"):
        pick = subprocess.run(
            ["wofi", "--dmenu", "--prompt", "Open local server"],
            input="\n".join(choices), text=True, capture_output=True, check=False,
        ).stdout.strip()
        if not pick:
            return
        target = pick
    subprocess.Popen(["xdg-open", target], start_new_session=True)


def main():
    ports = servers()
    if len(sys.argv) > 1 and sys.argv[1] == "--open":
        open_server(ports)
        return
    text = "  ".join(f"󰖟 {port}" for port in ports)
    tooltip = "No local development servers" if not ports else (
        "Open local server" if len(ports) == 1 else "Choose a local server to open"
    )
    print(json.dumps({"text": text, "tooltip": tooltip, "class": "active" if ports else "empty"}))


if __name__ == "__main__":
    main()

