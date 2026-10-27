import 'package:dio/dio.dart';
import '../../../core/api_client.dart';

class InventoryDataSource {
  InventoryDataSource(this.dio);
  final Dio dio;
  Future<dynamic> request(
    String path, {
    String method = 'GET',
    Map<String, dynamic>? query,
    Map<String, dynamic>? body,
  }) async {
    try {
      final response = await dio.request<dynamic>(
        path,
        queryParameters: query,
        data: body,
        options: Options(method: method),
      );
      return response.data;
    } on DioException catch (error) {
      final data = error.response?.data;
      if (data is Map &&
          data['error'] is Map &&
          data['error']['message'] is String) {
        throw ApiException(data['error']['message'] as String);
      }
      if (error.response?.statusCode == 404) {
        throw const ApiException('Produk tidak ditemukan.');
      }
      if (error.response?.statusCode == 409) {
        throw const ApiException(
          'Data berbenturan dengan data yang sudah ada.',
        );
      }
      throw const ApiException(
        'Tidak dapat terhubung ke API. Periksa koneksi dan alamat server.',
      );
    }
  }
}
