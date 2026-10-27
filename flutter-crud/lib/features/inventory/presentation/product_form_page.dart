import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/api_client.dart';
import '../data/models.dart';
import '../state/inventory_providers.dart';
import 'shared.dart';

class ProductFormPage extends ConsumerWidget {
  const ProductFormPage({super.key, this.id});
  final int? id;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Widget form(Product? product) => ref
        .watch(categoriesProvider)
        .when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error:
              (e, st) => FailureView(
                error: e,
                onRetry: () => ref.invalidate(categoriesProvider),
              ),
          data:
              (categories) =>
                  categories.isEmpty
                      ? const Center(
                        child: Text(
                          'Buat kategori melalui seed database terlebih dahulu.',
                        ),
                      )
                      : ProductForm(
                        key: ValueKey(product?.id),
                        product: product,
                        categories: categories,
                      ),
        );
    return Scaffold(
      appBar: AppBar(title: Text(id == null ? 'Tambah produk' : 'Edit produk')),
      body: ContentWidth(
        child:
            id == null
                ? form(null)
                : ref
                    .watch(productProvider(id!))
                    .when(
                      loading:
                          () =>
                              const Center(child: CircularProgressIndicator()),
                      error:
                          (e, st) => FailureView(
                            error: e,
                            onRetry: () => ref.invalidate(productProvider(id!)),
                          ),
                      data: form,
                    ),
      ),
    );
  }
}

class ProductForm extends ConsumerStatefulWidget {
  const ProductForm({
    super.key,
    required this.product,
    required this.categories,
  });
  final Product? product;
  final List<Category> categories;
  @override
  ConsumerState<ProductForm> createState() => _ProductFormState();
}

class _ProductFormState extends ConsumerState<ProductForm> {
  final formKey = GlobalKey<FormState>();
  late final TextEditingController name, sku, price, stock;
  late int category;
  bool saving = false;
  @override
  void initState() {
    super.initState();
    final p = widget.product;
    name = TextEditingController(text: p?.name ?? '');
    sku = TextEditingController(text: p?.sku ?? '');
    price = TextEditingController(text: p?.price.toStringAsFixed(2) ?? '');
    stock = TextEditingController(text: p?.stock.toString() ?? '');
    category = p?.categoryId ?? widget.categories.first.id;
  }

  @override
  void dispose() {
    name.dispose();
    sku.dispose();
    price.dispose();
    stock.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (saving || !formKey.currentState!.validate()) return;
    setState(() => saving = true);
    try {
      final result = await ref
          .read(inventoryRepositoryProvider)
          .save(
            ProductDraft(
              name: name.text.trim(),
              sku: sku.text.trim(),
              categoryId: category,
              price: double.parse(price.text.replaceAll(',', '.')),
              stock: int.parse(stock.text),
            ),
            id: widget.product?.id,
          );
      ref.invalidate(productsProvider);
      ref.invalidate(productProvider(result.id));
      if (mounted) context.go('/products/${result.id}');
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(errorMessage(error))));
      }
    } finally {
      if (mounted) setState(() => saving = false);
    }
  }

  @override
  Widget build(BuildContext context) => Form(
    key: formKey,
    child: ListView(
      padding: const EdgeInsets.all(24),
      children: [
        Text(
          'Informasi barang',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 24),
        TextFormField(
          key: const Key('name'),
          controller: name,
          maxLength: 120,
          enabled: !saving,
          decoration: const InputDecoration(
            labelText: 'Nama produk',
            border: OutlineInputBorder(),
          ),
          validator:
              (v) => v == null || v.trim().isEmpty ? 'Nama wajib diisi.' : null,
        ),
        const SizedBox(height: 12),
        TextFormField(
          key: const Key('sku'),
          controller: sku,
          maxLength: 40,
          enabled: !saving,
          decoration: const InputDecoration(
            labelText: 'SKU',
            helperText: 'Unik; huruf, angka, _ atau -',
            border: OutlineInputBorder(),
          ),
          validator:
              (v) =>
                  v == null ||
                          !RegExp(r'^[A-Za-z0-9_-]{1,40}$').hasMatch(v.trim())
                      ? 'SKU tidak valid.'
                      : null,
        ),
        const SizedBox(height: 20),
        DropdownButtonFormField<int>(
          value: category,
          decoration: const InputDecoration(
            labelText: 'Kategori',
            border: OutlineInputBorder(),
          ),
          items:
              widget.categories
                  .map(
                    (c) => DropdownMenuItem(value: c.id, child: Text(c.name)),
                  )
                  .toList(),
          onChanged: saving ? null : (v) => setState(() => category = v!),
          validator: (v) => v == null ? 'Pilih kategori.' : null,
        ),
        const SizedBox(height: 20),
        TextFormField(
          key: const Key('price'),
          controller: price,
          enabled: !saving,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: const InputDecoration(
            labelText: 'Harga (rupiah)',
            helperText: 'Contoh: 12500,50; tanpa pemisah ribuan',
            border: OutlineInputBorder(),
          ),
          validator: (v) {
            final text = (v ?? '').replaceAll(',', '.');
            final number = double.tryParse(text);
            return !RegExp(r'^\d+(\.\d{1,2})?$').hasMatch(text) ||
                    number == null ||
                    !number.isFinite ||
                    number > 9999999999.99
                ? 'Harga 0–9999999999,99; maksimal 2 desimal.'
                : null;
          },
        ),
        const SizedBox(height: 20),
        TextFormField(
          key: const Key('stock'),
          controller: stock,
          enabled: !saving,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: 'Stok',
            border: OutlineInputBorder(),
          ),
          validator: (v) {
            final number = int.tryParse(v ?? '');
            return number == null || number < 0 || number > 2147483647
                ? 'Stok harus bilangan bulat 0–2147483647.'
                : null;
          },
        ),
        const SizedBox(height: 28),
        FilledButton(
          onPressed: saving ? null : _save,
          child:
              saving
                  ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                  : const Text('Simpan'),
        ),
      ],
    ),
  );
}
