# Git, repository public, dan GitHub Pages

Source siap dipublikasikan, tetapi URL publik hanya ada setelah push dan deployment berhasil. Tidak ada credential GitHub yang disertakan. ZIP dikemas dengan script `python3 scripts/package.py`, tanpa .env/cache/dependency/build/.git.

## Publikasi manual

1. Login GitHub di browser dengan akun sendiri. Klik **New repository**, nama `mobile-developer-technical-test-masterclass`, pilih **Public**, jangan centang generate README/license/gitignore karena source sudah punya. Create repository.
2. Di root lokal, periksa `git status`. Jika folder belum repository:

```bash
git init -b main
git add .
git status --short
git diff --cached --stat
```

3. Pastikan .env, local.properties, key.properties, keystore, node_modules, build, serta file pribadi tidak masuk staging. Gunakan .env.example saja. Lalu:

```bash
git commit -m "feat: tambah masterclass Kotlin MySQL Flutter"
git remote add origin https://github.com/USERNAME/mobile-developer-technical-test-masterclass.git
git push -u origin main
```

Ganti USERNAME. Jika remote sudah ada, `git remote -v` dahulu dan jangan menimpanya tanpa alasan. GitHub tidak menerima password akun sebagai password Git HTTPS; gunakan credential manager/browser auth atau token dengan scope minimal melalui pengelola kredensial. Jangan menaruh token di remote URL atau file.

## GitHub CLI bila sudah terpasang dan login

`gh auth status` memeriksa autentikasi. Dari repository lokal yang sudah mempunyai commit: `gh repo create mobile-developer-technical-test-masterclass --public --source=. --remote=origin --push`. Jangan jalankan jika remote/repo sudah ada; gunakan cara push biasa. Perintah ini benar-benar membuat repository public.

## Pages tanpa login bagi pengunjung

Buka Settings → Pages → Build and deployment → Source → **GitHub Actions**. Workflow `.github/workflows/pages.yml` mengunggah hanya folder simulator, tanpa backend, source .env, atau file lain. Push ke main memicu deploy; bisa juga Run workflow di tab Actions. Tunggu job deploy sukses. URL lazimnya `https://USERNAME.github.io/mobile-developer-technical-test-masterclass/`, tetapi gunakan URL deployment yang benar-benar dicetak GitHub. Jika akun memakai domain khusus, URL bisa berbeda.

Verifikasi dari private/incognito window tanpa login: simulator terbuka, Step Forward/Back berfungsi, Run to End membentuk diamond, serta mode latihan menyembunyikan jawaban. Repo public dan Pages adalah dua pengaturan terpisah; membuat repository public tidak otomatis mengaktifkan Pages. Jika Pages 404, cek Source GitHub Actions, branch main, hasil workflow, dan path relatif aset.

## Kontribusi

Buat branch (`git switch -c perbaikan/nama-singkat`), ubah satu topik, jalankan checks terkait, commit, push branch, lalu Pull Request. Jelaskan masalah, perilaku sesudah perubahan, dan verifikasi. Materi/pembahasan baru harus tetap Bahasa Indonesia, punya kontrak input dan edge case. Jangan mengirim jawaban latihan yang belum diuji.
