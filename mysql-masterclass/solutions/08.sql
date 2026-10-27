-- Tampilkan pelanggan yang belum memiliki nomor telepon.
-- NULL berarti tidak diketahui; = NULL tidak pernah true.
SELECT id, name FROM customers WHERE phone IS NULL ORDER BY id;
