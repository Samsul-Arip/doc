import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:inventory_masterclass/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  testWidgets('CRUD melalui API nyata dari perangkat', (tester) async {
    final suffix = DateTime.now().millisecondsSinceEpoch;
    final name = 'Uji Emulator $suffix';
    app.main();
    await tester.pumpAndSettle();
    // API dan database harus siap sebelum menjalankan tes ini.
    expect(find.text('Inventaris'), findsOneWidget);
    await tester.tap(find.text('Tambah produk'));
    await tester.pumpAndSettle();
    for (final entry
        in {
          'name': name,
          'sku': 'IT-$suffix',
          'price': '12500,50',
          'stock': '3',
        }.entries) {
      final field = find.byKey(Key(entry.key));
      await tester.ensureVisible(field);
      await tester.enterText(field, entry.value);
    }
    await tester.ensureVisible(find.widgetWithText(FilledButton, 'Simpan'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Simpan'));
    await tester.pumpAndSettle();
    expect(find.text(name), findsOneWidget);
    await tester.tap(find.text('Edit produk'));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.byKey(const Key('stock')));
    await tester.enterText(find.byKey(const Key('stock')), '7');
    await tester.ensureVisible(find.widgetWithText(FilledButton, 'Simpan'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Simpan'));
    await tester.pumpAndSettle();
    expect(find.text('Stok: 7'), findsOneWidget);
    await tester.tap(find.text('Hapus produk'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Hapus'));
    await tester.pumpAndSettle();
    expect(find.text('Inventaris'), findsOneWidget);
    await tester.enterText(find.byKey(const Key('search')), name);
    await tester.pump(const Duration(milliseconds: 400));
    await tester.pumpAndSettle();
    expect(find.text('Belum ada produk yang cocok.'), findsOneWidget);
  });
}
