-- Tampilkan pesanan Januari 2026 memakai rentang ramah indeks.
-- Rentang setengah terbuka mencakup seluruh jam; hindari membungkus kolom waktu dalam fungsi.
SELECT id, status FROM orders WHERE ordered_at >= '2026-01-01' AND ordered_at < '2026-02-01' ORDER BY id;
