import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ApiException implements Exception {
  const ApiException(this.message);
  final String message;
  @override
  String toString() => message;
}

String errorMessage(Object error) =>
    error is ApiException
        ? error.message
        : 'Data gagal dimuat. Silakan coba kembali.';
final dioProvider = Provider<Dio>((ref) {
  const baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://10.0.2.2:3000/api',
  );
  final dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 8),
      receiveTimeout: const Duration(seconds: 12),
      sendTimeout: const Duration(seconds: 12),
      headers: {'Accept': 'application/json'},
    ),
  );
  ref.onDispose(() => dio.close(force: true));
  return dio;
});
