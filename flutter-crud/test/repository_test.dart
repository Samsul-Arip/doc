import 'dart:convert';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inventory_masterclass/core/api_client.dart';
import 'package:inventory_masterclass/features/inventory/data/inventory_data_source.dart';
import 'package:inventory_masterclass/features/inventory/data/inventory_repository.dart';

class StubAdapter implements HttpClientAdapter {
  StubAdapter(this.status, this.body);
  final int status;
  final dynamic body;
  RequestOptions? last;
  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    last = options;
    return ResponseBody.fromString(
      jsonEncode(body),
      status,
      headers: {
        Headers.contentTypeHeader: ['application/json'],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}

void main() {
  test('mengirim pagination, search dan kategori', () async {
    final adapter = StubAdapter(200, {
      'data': [],
      'meta': {'page': 2, 'total': 0, 'totalPages': 0},
    });
    final dio = Dio()..httpClientAdapter = adapter;
    final repo = ApiInventoryRepository(InventoryDataSource(dio));
    await repo.list(page: 2, search: 'a & b', categoryId: 3);
    expect(adapter.last?.queryParameters, {
      'page': 2,
      'limit': 20,
      'search': 'a & b',
      'categoryId': 3,
    });
    dio.close();
  });
  test('memetakan pesan konflik SKU', () async {
    final dio =
        Dio()
          ..httpClientAdapter = StubAdapter(409, {
            'error': {'message': 'SKU sudah digunakan.'},
          });
    expect(
      () => ApiInventoryRepository(InventoryDataSource(dio)).get(1),
      throwsA(
        isA<ApiException>().having(
          (e) => e.message,
          'message',
          'SKU sudah digunakan.',
        ),
      ),
    );
    dio.close();
  });
  test('mengubah JSON rusak menjadi error yang bisa ditampilkan', () async {
    final dio =
        Dio()..httpClientAdapter = StubAdapter(200, {'data': 'bukan list'});
    expect(
      () => ApiInventoryRepository(InventoryDataSource(dio)).list(),
      throwsA(isA<ApiException>()),
    );
    dio.close();
  });
}
