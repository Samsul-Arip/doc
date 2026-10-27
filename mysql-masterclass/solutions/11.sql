-- Pasangkan setiap produk dengan nama kategorinya (INNER JOIN).
-- ON menghubungkan foreign key produk dengan primary key kategori.
SELECT p.id, p.name, c.name AS category FROM products p INNER JOIN categories c ON c.id = p.category_id ORDER BY p.id;
