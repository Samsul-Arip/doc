import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/api_client.dart';
import '../state/inventory_providers.dart';
import 'shared.dart';

class ProductDetailPage extends ConsumerStatefulWidget {
  const ProductDetailPage({super.key, required this.id});
  final int id;
  @override
  ConsumerState<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends ConsumerState<ProductDetailPage> {
  bool deleting = false;
  Future<void> _delete() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder:
          (ctx) => AlertDialog(
            title: const Text('Hapus produk?'),
            content: const Text(
              'Produk yang masih dipakai pesanan tidak dapat dihapus.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx, false),
                child: const Text('Batal'),
              ),
              FilledButton(
                onPressed: () => Navigator.pop(ctx, true),
                child: const Text('Hapus'),
              ),
            ],
          ),
    );
    if (confirmed != true || !mounted) return;
    setState(() => deleting = true);
    try {
      await ref.read(inventoryRepositoryProvider).delete(widget.id);
      ref.read(pageProvider.notifier).state = 1;
      ref.invalidate(productsProvider);
      if (mounted) context.go('/');
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(errorMessage(error))));
      }
    } finally {
      if (mounted) setState(() => deleting = false);
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Detail produk')),
    body: ContentWidth(
      child: ref
          .watch(productProvider(widget.id))
          .when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error:
                (e, st) => FailureView(
                  error: e,
                  onRetry: () => ref.invalidate(productProvider(widget.id)),
                ),
            data:
                (p) => ListView(
                  padding: const EdgeInsets.all(24),
                  children: [
                    const Icon(Icons.inventory_2_outlined, size: 80),
                    const SizedBox(height: 24),
                    Text(
                      p.name,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    Text(p.sku),
                    const SizedBox(height: 24),
                    Text(
                      rupiah(p.price),
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 12),
                    Text('Stok: ${p.stock}'),
                    Text('ID kategori: ${p.categoryId}'),
                    Text('Dibuat (UTC): ${p.createdAt.toIso8601String()}'),
                    Text('Diubah (UTC): ${p.updatedAt.toIso8601String()}'),
                    const SizedBox(height: 24),
                    FilledButton.icon(
                      onPressed:
                          deleting
                              ? null
                              : () => context.push('/products/${p.id}/edit'),
                      icon: const Icon(Icons.edit_outlined),
                      label: const Text('Edit produk'),
                    ),
                    const SizedBox(height: 12),
                    OutlinedButton.icon(
                      onPressed: deleting ? null : _delete,
                      icon:
                          deleting
                              ? const SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(),
                              )
                              : const Icon(Icons.delete_outline),
                      label: const Text('Hapus produk'),
                    ),
                  ],
                ),
          ),
    ),
  );
}
