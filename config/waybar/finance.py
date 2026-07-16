#!/usr/bin/env python3
"""Optional, data-free finance placeholder for the Waybar finance module.

This public configuration ships no holdings, prices, accounts, or credentials.
Add user-owned display logic outside this repository before enabling it.
"""
import json

print(json.dumps({
    "text": "",
    "tooltip": "Finance module is disabled. Configure your own local data first.",
    "class": "disabled",
}))

