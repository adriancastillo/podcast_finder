import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'api_endpoints.dart';
import 'mock_interceptor.dart';

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: ApiEndpoints.baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        'Content-Type': 'application/json',
        'X-ListenAPI-Key': ApiEndpoints.mockApiKey,
      },
    ),
  );

  // Add mock interceptor for testing
  dio.interceptors.add(MockInterceptor());
  
  // Add logging interceptor in debug mode
  dio.interceptors.add(
    LogInterceptor(
      requestBody: true,
      responseBody: true,
      error: true,
    ),
  );

  return dio;
});