// Decoder eksplisit membuat JSON yang salah menjadi error terkontrol.
int jsonInt(dynamic value, String field) {
  final parsed = value is num ? value.toDouble() : double.tryParse('$value');
  if (parsed == null ||
      !parsed.isFinite ||
      parsed != parsed.roundToDouble() ||
      parsed < 0 ||
      parsed > 2147483647) {
    throw FormatException('Nilai $field tidak valid.');
  }
  return parsed.toInt();
}

String jsonText(dynamic value, String field) {
  if (value is! String || value.trim().isEmpty) {
    throw FormatException('Nilai $field tidak valid.');
  }
  return value;
}

class Category {
  const Category({required this.id, required this.name});
  final int id;
  final String name;
  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: jsonInt(json['id'], 'id'),
    name: jsonText(json['name'], 'name'),
  );
}

class Product {
  const Product({
    required this.id,
    required this.name,
    required this.sku,
    required this.categoryId,
    required this.price,
    required this.stock,
    required this.createdAt,
    required this.updatedAt,
  });
  final int id, categoryId, stock;
  final String name, sku;
  final double price;
  final DateTime createdAt, updatedAt;
  factory Product.fromJson(Map<String, dynamic> json) {
    final price = double.tryParse('${json['price']}');
    if (price == null ||
        !price.isFinite ||
        price < 0 ||
        price > 9999999999.99) {
      throw const FormatException('Harga tidak valid.');
    }
    return Product(
      id: jsonInt(json['id'], 'id'),
      name: jsonText(json['name'], 'name'),
      sku: jsonText(json['sku'], 'sku'),
      categoryId: jsonInt(json['categoryId'], 'categoryId'),
      price: price,
      stock: jsonInt(json['stock'], 'stock'),
      createdAt:
          DateTime.parse(jsonText(json['createdAt'], 'createdAt')).toUtc(),
      updatedAt:
          DateTime.parse(jsonText(json['updatedAt'], 'updatedAt')).toUtc(),
    );
  }
}

class ProductDraft {
  const ProductDraft({
    required this.name,
    required this.sku,
    required this.categoryId,
    required this.price,
    required this.stock,
  });
  final String name, sku;
  final int categoryId, stock;
  final double price;
  Map<String, dynamic> toJson() => {
    'name': name,
    'sku': sku,
    'categoryId': categoryId,
    'price': price,
    'stock': stock,
  };
}

class ProductPage {
  const ProductPage({
    required this.items,
    required this.page,
    required this.total,
    required this.totalPages,
  });
  final List<Product> items;
  final int page, total, totalPages;
  factory ProductPage.fromJson(Map<String, dynamic> json) {
    final data = json['data'];
    final meta = json['meta'];
    if (data is! List || meta is! Map<String, dynamic>) {
      throw const FormatException('Format daftar tidak valid.');
    }
    return ProductPage(
      items:
          data.map((e) => Product.fromJson(e as Map<String, dynamic>)).toList(),
      page: jsonInt(meta['page'], 'page'),
      total: jsonInt(meta['total'], 'total'),
      totalPages: jsonInt(meta['totalPages'], 'totalPages'),
    );
  }
}
