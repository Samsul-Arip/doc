import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/api_client.dart';
import '../data/inventory_data_source.dart';
import '../data/inventory_repository.dart';
import '../data/models.dart';

final inventoryRepositoryProvider = Provider<InventoryRepository>(
  (ref) => ApiInventoryRepository(InventoryDataSource(ref.watch(dioProvider))),
);
final searchProvider = StateProvider<String>((ref) => '');
final categoryFilterProvider = StateProvider<int?>((ref) => null);
final pageProvider = StateProvider<int>((ref) => 1);
// FutureProvider membuang hasil usang saat parameter pencarian berubah.
final productsProvider = FutureProvider.autoDispose<ProductPage>(
  (ref) => ref
      .watch(inventoryRepositoryProvider)
      .list(
        page: ref.watch(pageProvider),
        search: ref.watch(searchProvider),
        categoryId: ref.watch(categoryFilterProvider),
      ),
);
final categoriesProvider = FutureProvider<List<Category>>(
  (ref) => ref.watch(inventoryRepositoryProvider).categories(),
);
final productProvider = FutureProvider.autoDispose.family<Product, int>(
  (ref, id) => ref.watch(inventoryRepositoryProvider).get(id),
);
