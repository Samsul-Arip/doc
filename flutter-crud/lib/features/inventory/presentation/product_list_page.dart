import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../state/inventory_providers.dart';
import 'shared.dart';

class ProductListPage extends ConsumerStatefulWidget {
  const ProductListPage({super.key});
  @override
  ConsumerState<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends ConsumerState<ProductListPage> {
  Timer? _debounce;
  late final TextEditingController _search;
  @override
  void initState() {
    super.initState();
    _search = TextEditingController(text: ref.read(searchProvider));
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _search.dispose();
    super.dispose();
  }

  Future<void> _refresh() async {
    try {
      ref.invalidate(productsProvider);
      await ref.read(productsProvider.future);
    } catch (_) {
      /* Error ditampilkan oleh AsyncValue. */
    }
  }

  @override
  Widget build(BuildContext context) {
    final products = ref.watch(productsProvider);
    final categories = ref.watch(categoriesProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Inventaris')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/products/new'),
        icon: const Icon(Icons.add),
        label: const Text('Tambah produk'),
      ),
      body: ContentWidth(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
              child: TextField(
                controller: _search,
                key: const Key('search'),
                decoration: const InputDecoration(
                  labelText: 'Cari nama atau SKU',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  _debounce?.cancel();
                  _debounce = Timer(const Duration(milliseconds: 350), () {
                    ref.read(pageProvider.notifier).state = 1;
                    ref.read(searchProvider.notifier).state = value;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: categories.when(
                data:
                    (items) => DropdownButtonFormField<int>(
                      value: ref.watch(categoryFilterProvider) ?? 0,
                      isExpanded: true,
                      decoration: const InputDecoration(
                        labelText: 'Kategori',
                        border: OutlineInputBorder(),
                      ),
                      items: [
                        const DropdownMenuItem(
                          value: 0,
                          child: Text('Semua kategori'),
                        ),
                        ...items.map(
                          (e) => DropdownMenuItem(
                            value: e.id,
                            child: Text(e.name),
                          ),
                        ),
                      ],
                      onChanged: (value) {
                        ref.read(pageProvider.notifier).state = 1;
                        ref.read(categoryFilterProvider.notifier).state =
                            value == 0 ? null : value;
                      },
                    ),
                loading: () => const LinearProgressIndicator(),
                error:
                    (e, st) => Row(
                      children: [
                        const Expanded(child: Text('Kategori gagal dimuat.')),
                        TextButton(
                          onPressed: () => ref.invalidate(categoriesProvider),
                          child: const Text('Ulangi'),
                        ),
                      ],
                    ),
              ),
            ),
            Expanded(
              child: products.when(
                skipLoadingOnRefresh: false,
                loading: () => const Center(child: CircularProgressIndicator()),
                error:
                    (e, st) => FailureView(
                      error: e,
                      onRetry: () => ref.invalidate(productsProvider),
                    ),
                data:
                    (page) => RefreshIndicator(
                      onRefresh: _refresh,
                      child: ListView(
                        padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
                        physics: const AlwaysScrollableScrollPhysics(),
                        children: [
                          Text(
                            '${page.total} produk',
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                          const SizedBox(height: 12),
                          if (page.items.isEmpty)
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 60),
                              child: Column(
                                children: [
                                  Icon(Icons.inventory_2_outlined, size: 56),
                                  SizedBox(height: 12),
                                  Text('Belum ada produk yang cocok.'),
                                  Text('Tambahkan produk atau ubah pencarian.'),
                                ],
                              ),
                            )
                          else
                            ...page.items.map(
                              (p) => Card(
                                child: ListTile(
                                  contentPadding: const EdgeInsets.all(16),
                                  leading: CircleAvatar(
                                    child: Text(
                                      p.name.substring(0, 1).toUpperCase(),
                                    ),
                                  ),
                                  title: Text(p.name),
                                  subtitle: Text(
                                    '${p.sku}\n${rupiah(p.price)} • Stok ${p.stock}',
                                  ),
                                  isThreeLine: true,
                                  trailing: const Icon(Icons.chevron_right),
                                  onTap:
                                      () => context.push('/products/${p.id}'),
                                ),
                              ),
                            ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                tooltip: 'Halaman sebelumnya',
                                onPressed:
                                    page.page > 1
                                        ? () =>
                                            ref
                                                .read(pageProvider.notifier)
                                                .state--
                                        : null,
                                icon: const Icon(Icons.chevron_left),
                              ),
                              Text(
                                'Halaman ${page.page} / ${page.totalPages == 0 ? 1 : page.totalPages}',
                              ),
                              IconButton(
                                tooltip: 'Halaman berikutnya',
                                onPressed:
                                    page.page < page.totalPages
                                        ? () =>
                                            ref
                                                .read(pageProvider.notifier)
                                                .state++
                                        : null,
                                icon: const Icon(Icons.chevron_right),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
