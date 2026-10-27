-- Hitung produk tiap kategori, termasuk kategori kosong (LEFT JOIN).
-- COUNT(p.id) mengabaikan NULL hasil LEFT JOIN; COUNT(*) akan salah untuk kategori kosong.
SELECT c.id, c.name, COUNT(p.id) AS product_count FROM categories c LEFT JOIN products p ON p.category_id = c.id GROUP BY c.id, c.name ORDER BY c.id;
