"""Kemas hanya file terdaftar Git, tanpa rahasia, cache atau artefak build."""
from pathlib import Path
import subprocess
import zipfile
root = Path(__file__).resolve().parents[1]
output = root.parent / 'mobile-developer-technical-test-masterclass.zip'
files = subprocess.check_output(['git', 'ls-files', '-z'], cwd=root).decode().split('\0')
with zipfile.ZipFile(output, 'w', zipfile.ZIP_DEFLATED) as archive:
    for name in files:
        if not name:
            continue
        path = root / name
        if path.is_symlink() or not path.is_file():
            continue
        if path.name.startswith('.env') and path.name != '.env.example':
            raise SystemExit('Rahasia .env tidak boleh masuk arsip.')
        info = zipfile.ZipInfo.from_file(path, 'mobile-developer-technical-test-masterclass/' + name)
        info.compress_type = zipfile.ZIP_DEFLATED
        archive.writestr(info, path.read_bytes())
print(output)
