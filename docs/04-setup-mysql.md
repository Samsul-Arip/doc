# Menjalankan MySQL 8 dan menyiapkan data

Database latihan **masterclass** dipakai bersama materi SQL dan API. Reset menghapus perubahan CRUD; hentikan API dan jangan gunakan database kerja. Seluruh seed deterministik; tanggal bukan waktu saat seed dijalankan. Data contoh fiktif.

## Opsi Docker (paling sedikit konfigurasi)

Dari root repository:

```bash
cp .env.example .env
```

Windows PowerShell: `Copy-Item .env.example .env`. Edit `.env` dengan editor, ganti dua password CHANGEME, dan pertahankan `MYSQL_DATABASE=masterclass` untuk mengikuti reset. Password contoh adalah placeholder, bukan kredensial asli. Jangan commit `.env`.

```bash
docker compose up -d --build
docker compose ps
docker compose logs --tail=50 mysql backend
curl http://localhost:3000/health
curl http://localhost:3000/ready
```

PowerShell gunakan `curl.exe` agar tidak terkena alias Invoke-WebRequest. Endpoint `/health` hanya menyatakan proses hidup; `/ready` memeriksa koneksi DB. Keduanya harus HTTP 200 sebelum Flutter dijalankan. Init schema/seed berjalan hanya saat volume mysql_data pertama kali kosong.

Buka SQL prompt dengan `docker compose exec mysql mysql -u root -p masterclass`. Masukkan password root yang kamu isi, lalu `SELECT VERSION();` dan `SELECT COUNT(*) FROM products;` → 8 pada seed asli.

**Reset Docker yang sudah berisi data**, tanpa menghapus volume:

```bash
docker compose stop backend
docker compose cp mysql-masterclass mysql:/tmp/mysql-masterclass
docker compose exec -w /tmp mysql mysql -u root -p
```

Di prompt MySQL, jalankan `SOURCE mysql-masterclass/reset.sql;`, lalu `exit;`. Setelah itu `docker compose start backend`. Reset ini sengaja eksplisit karena menghapus tabel latihan. Alternatif `docker compose down` hanya menghentikan dan menghapus container/network; data volume tetap ada. Jangan menambahkan `-v` kecuali memang ingin menghapus semua data lokal Compose.

## Opsi native tanpa Docker

Pastikan MySQL server berjalan, bukan hanya client. Login administrator:

```bash
mysql -u root -p
```

Pada Ubuntu dengan socket auth gunakan `sudo mysql`. Di prompt SQL (ganti password contoh sendiri sebelum menjalankan):

```sql
CREATE DATABASE IF NOT EXISTS masterclass CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
CREATE USER IF NOT EXISTS 'inventory'@'localhost' IDENTIFIED BY 'GANTI_PASSWORD_LOKAL_ANDA';
GRANT SELECT, INSERT, UPDATE, DELETE ON masterclass.* TO 'inventory'@'localhost';
SELECT VERSION();
exit;
```

User aplikasi hanya DML. Schema/reset memerlukan akun administrator. Bila MySQL native mengharuskan host 127.0.0.1 sebagai akun berbeda, buat akun dengan host tersebut dan grant sama; jangan memakai '%' tanpa kebutuhan. Masukkan password melalui prompt `-p`, bukan argumen command line. Dari root repository di bash/zsh/Git Bash:

```bash
mysql -u root -p < mysql-masterclass/schema/00-database.sql
mysql -u root -p masterclass < mysql-masterclass/schema/01-tables.sql
mysql -u root -p masterclass < mysql-masterclass/seed/02-seed.sql
mysql -u inventory -p masterclass -e "SELECT COUNT(*) AS products FROM products;"
```

Pada PowerShell, operator `<` tidak seperti bash. Gunakan `mysql -u root -p`, lalu perintah client `SOURCE C:/path/repository/mysql-masterclass/schema/00-database.sql;`, `USE masterclass;`, `SOURCE C:/path/repository/mysql-masterclass/schema/01-tables.sql;`, dan `SOURCE C:/path/repository/mysql-masterclass/seed/02-seed.sql;`. Gunakan slash maju dan path aktual. Alternatif jalankan blok bash di Git Bash.

Jika seed sudah ada, jangan jalankan lagi; duplicate key memang akan ditolak. Untuk mengulang dari root repository: `mysql -u root -p < mysql-masterclass/reset.sql`. Jangan menonaktifkan foreign key untuk memaksa hapus data acak; reset menghapus tabel sesuai urutan dependensinya.

## Menjalankan latihan dan memverifikasi

`mysql -u inventory -p masterclass < mysql-masterclass/solutions/01.sql` menjalankan satu solusi. Buka 35 soal sebelum melihat jawaban. Verifikasi otomatis memakai akun latihan dan variabel lingkungan:

```bash
export DB_HOST=127.0.0.1 DB_PORT=3306 DB_USER=inventory DB_NAME=masterclass
read -s -p 'Password DB: ' DB_PASSWORD
export DB_PASSWORD
node mysql-masterclass/tests/verify.mjs
unset DB_PASSWORD
```

`read -s -p` di atas untuk **bash**; zsh dapat memakai `read -s 'DB_PASSWORD?Password DB: '` lalu export. Di PowerShell gunakan variabel sesi `$env:DB_HOST`, `$env:DB_USER`, `$env:DB_NAME`, dan `$env:DB_PASSWORD` (baca via `Read-Host -AsSecureString` bila perlu). Script tidak membaca backend/.env secara otomatis; jangan menampilkan password ke layar atau menaruhnya pada history. Jalankan `npm ci --prefix backend` dahulu agar mysql2 tersedia.

Saat API pernah mengubah data, reset dahulu agar expected result tidak berbeda. CI menggunakan MySQL 8.4 asli, menjalankan schema/seed, 35 query, dan tes HTTP integrasi database.
