"""Periksa target link Markdown lokal tanpa mengakses internet."""
from pathlib import Path
import re
root = Path(__file__).resolve().parents[1]
failures = []
for path in root.rglob('*.md'):
    if any(part in {'node_modules', '.dart_tool', 'build', '.git'} for part in path.parts):
        continue
    for target in re.findall(r'\]\(([^)]+)\)', path.read_text()):
        if '://' in target or target.startswith('#'):
            continue
        target = target.split('#')[0].strip('<>')
        if target and not (path.parent / target).exists():
            failures.append(f'{path.relative_to(root)} → {target}')
if failures:
    raise SystemExit('\n'.join(failures))
print('Seluruh tautan Markdown lokal valid.')
