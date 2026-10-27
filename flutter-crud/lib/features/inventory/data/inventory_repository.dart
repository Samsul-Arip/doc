import 'models.dart';
import 'inventory_data_source.dart';
import '../../../core/api_client.dart';

abstract class InventoryRepository {
  Future<ProductPage> list({int page = 1, String search = '', int? categoryId});
  Future<Product> get(int id);
  Future<List<Category>> categories();
  Future<Product> save(ProductDraft draft, {int? id});
  Future<void> delete(int id);
}

class ApiInventoryRepository implements InventoryRepository {
  ApiInventoryRepository(this.source);
  final InventoryDataSource source;
  Future<T> _decode<T>(Future<T> Function() task) async {
    try {
      return await task();
    } on FormatException {
      throw const ApiException('Format data server tidak sesuai.');
    } on TypeError {
      throw const ApiException('Format data server tidak sesuai.');
    }
  }

  @override
  Future<ProductPage> list({
    int page = 1,
    String search = '',
    int? categoryId,
  }) => _decode(
    () async => ProductPage.fromJson(
      await source.request(
            '/products',
            query: {
              'page': page,
              'limit': 20,
              'search': search,
              if (categoryId != null) 'categoryId': categoryId,
            },
          )
          as Map<String, dynamic>,
    ),
  );
  @override
  Future<Product> get(int id) => _decode(() async {
    final json = await source.request('/products/$id');
    return Product.fromJson(json['data'] as Map<String, dynamic>);
  });
  @override
  Future<List<Category>> categories() => _decode(() async {
    final json = await source.request('/categories');
    return (json['data'] as List)
        .map((e) => Category.fromJson(e as Map<String, dynamic>))
        .toList();
  });
  @override
  Future<Product> save(ProductDraft draft, {int? id}) => _decode(() async {
    final json = await source.request(
      id == null ? '/products' : '/products/$id',
      method: id == null ? 'POST' : 'PUT',
      body: draft.toJson(),
    );
    return Product.fromJson(json['data'] as Map<String, dynamic>);
  });
  @override
  Future<void> delete(int id) async {
    await source.request('/products/$id', method: 'DELETE');
  }
}
