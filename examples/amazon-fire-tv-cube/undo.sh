#!/usr/bin/env bash
# One-line undo: re-enable every package in the Fire TV Cube ads/tracking list, then put back the default DNS.
export TV_HOST=${TV_HOST:-192.168.0.5}; T="tools/venv/Scripts/python.exe -I tools/tv.py"; for p in $(grep -vE "^\s*(#|$)" examples/amazon-fire-tv-cube/debloat.txt | awk "{print \$1}"); do $T pm enable "$p"; done; $T settings delete global private_dns_mode; $T settings delete global private_dns_specifier
