#!/usr/bin/env python3
"""Setzt Versionsstempel + Notiz in index.html und schreibt version.json.
Aufruf: python3 tools/release.py "Was ist neu (kurz)"
"""
import json, re, sys, datetime, pathlib
root = pathlib.Path(__file__).resolve().parent.parent
notes = (sys.argv[1] if len(sys.argv) > 1 else '').strip()
ver = datetime.datetime.now(datetime.timezone.utc).strftime('%Y-%m-%dT%H:%M:%SZ')
idx = root / 'index.html'
h = idx.read_text(encoding='utf-8')
h, n1 = re.subn(r"const APP_VERSION='[^']*';", f"const APP_VERSION='{ver}';", h)
h, n2 = re.subn(r"const APP_NOTES=.*?;\n", "const APP_NOTES=" + json.dumps(notes, ensure_ascii=False) + ";\n", h, count=1)
assert n1 == 1 and n2 == 1, (n1, n2)
idx.write_text(h, encoding='utf-8')
(root / 'version.json').write_text(json.dumps({'version': ver, 'notes': notes}, ensure_ascii=False, indent=2) + '\n', encoding='utf-8')
print(ver)
