import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inventory_masterclass/app.dart';
import 'package:inventory_masterclass/core/api_client.dart';
import 'package:inventory_masterclass/features/inventory/data/inventory_repository.dart';
import 'package:inventory_masterclass/features/inventory/data/models.dart';
import 'package:inventory_masterclass/features/inventory/state/inventory_providers.dart';

class FakeRepository implements InventoryRepository {
  Future<ProductPage> Function()? onList;
  int saves = 0;
  @override
  Future<ProductPage> list({
    int page = 1,
    String search = '',
    int? categoryId,
  }) =>
      onList?.call() ??
      Future.value(
        const ProductPage(items: [], page: 1, total: 0, totalPages: 0),
      );
  @override
  Future<List<Category>> categories() async => [
    const Category(id: 1, name: 'Elektronik'),
  ];
  @override
  Future<Product> get(int id) async => Product(
    id: id,
    name: 'Barang Uji',
    sku: 'UJI',
    categoryId: 1,
    price: 100,
    stock: 2,
    createdAt: DateTime.utc(2026),
    updatedAt: DateTime.utc(2026),
  );
  @override
  Future<Product> save(ProductDraft draft, {int? id}) async {
    saves++;
    return get(id ?? 9);
  }

  @override
  Future<void> delete(int id) async {}
}

void main() {
  Future<void> start(WidgetTester tester, FakeRepository repo) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [inventoryRepositoryProvider.overrideWithValue(repo)],
        child: const InventoryApp(),
      ),
    );
  }

  testWidgets('loading berubah ke empty state', (tester) async {
    final complete = Completer<ProductPage>();
    final repo = FakeRepository()..onList = () => complete.future;
    await start(tester, repo);
    await tester.pump();
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    complete.complete(
      const ProductPage(items: [], page: 1, total: 0, totalPages: 0),
    );
    await tester.pumpAndSettle();
    expect(find.text('Belum ada produk yang cocok.'), findsOneWidget);
  });
  testWidgets('error dapat dicoba ulang', (tester) async {
    var first = true;
    final repo =
        FakeRepository()
          ..onList = () async {
            if (first) throw const ApiException('API mati');
            return const ProductPage(
              items: [],
              page: 1,
              total: 0,
              totalPages: 0,
            );
          };
    await start(tester, repo);
    await tester.pumpAndSettle();
    expect(find.text('API mati'), findsOneWidget);
    first = false;
    await tester.tap(find.text('Coba lagi'));
    await tester.pumpAndSettle();
    expect(find.text('0 produk'), findsOneWidget);
  });
  testWidgets('form menolak kosong dan menyimpan input valid', (tester) async {
    final repo = FakeRepository();
    await start(tester, repo);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Tambah produk'));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.widgetWithText(FilledButton, 'Simpan'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Simpan'));
    await tester.pumpAndSettle();
    expect(repo.saves, 0);
    expect(find.text('Nama wajib diisi.'), findsOneWidget);
    for (final entry
        in {
          'name': 'Barang Uji',
          'sku': 'UJI',
          'price': '100,25',
          'stock': '2',
        }.entries) {
      final field = find.byKey(Key(entry.key));
      await tester.ensureVisible(field);
      await tester.enterText(field, entry.value);
    }
    await tester.ensureVisible(find.widgetWithText(FilledButton, 'Simpan'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Simpan'));
    await tester.pumpAndSettle();
    expect(repo.saves, 1);
    expect(find.text('Detail produk'), findsOneWidget);
  });
}
