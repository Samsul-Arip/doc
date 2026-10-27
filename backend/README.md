# Backend Inventory API

Lihat [setup dan kontrak HTTP](../docs/05-setup-backend.md). Jalankan dari folder ini: `cp .env.example .env`, isi koneksi, `npm ci`, `npm run dev`. Node24 LTS diperlukan. Database harus diisi schema/seed; `GET /ready` menguji ketersediaannya.

Pemeriksaan: `npm run format:check`, `npm run lint`, `npm test`, `npm run build`. Dua tes MySQL hanya aktif ketika `MYSQL_TEST=1` dan variabel DB terisi. Tes default fake repository tidak membuktikan koneksi MySQL.

API ini ditujukan latihan lokal tanpa autentikasi. Simulator Pages dapat dipublikasikan terpisah; backend membutuhkan konfigurasi produksi sebelum akses internet. Docker Compose di root menyiapkan API dan MySQL sekaligus.
