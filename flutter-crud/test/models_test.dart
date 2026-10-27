import 'package:flutter_test/flutter_test.dart';
import 'package:inventory_masterclass/features/inventory/data/models.dart';

void main() {
  final valid = {
    'id': 1,
    'name': 'Keyboard',
    'sku': 'KEY',
    'categoryId': 2,
    'price': '12.50',
    'stock': 0,
    'createdAt': '2026-01-01T00:00:00Z',
    'updatedAt': '2026-01-01T01:00:00Z',
  };
  test('menerima DECIMAL string serta waktu UTC', () {
    final p = Product.fromJson(valid);
    expect(p.price, 12.5);
    expect(p.stock, 0);
    expect(p.createdAt.isUtc, true);
  });
  test('menolak data korup tanpa silently memberi default nol', () {
    for (final pair in [
      ('price', 'NaN'),
      ('stock', -1),
      ('id', 1.5),
      ('name', null),
      ('createdAt', 'kemarin'),
    ]) {
      expect(
        () => Product.fromJson({...valid, pair.$1: pair.$2}),
        throwsFormatException,
      );
    }
  });
  test('draft hanya mengirim field yang boleh ditulis', () {
    final body =
        const ProductDraft(
          name: 'x',
          sku: 'X',
          categoryId: 1,
          price: 0,
          stock: 0,
        ).toJson();
    expect(
      body.keys,
      unorderedEquals(['name', 'sku', 'categoryId', 'price', 'stock']),
    );
  });
}
