import 'package:dio/dio.dart';
import 'package:bloc_testing/core/constant/constant.dart';

class ApiClient {
  late final Dio _dio;

  ApiClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: ApiConstants.connectTimeout,
        receiveTimeout: ApiConstants.receiveTimeout,
        headers: {'Content-Type': 'application/json'},
      ),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          print(
            '➡️ REQUEST: ${options.method} ${options.baseUrl}${options.path}',
          );
          print('Headers: ${options.headers}');
          return handler.next(options);
        },

        onResponse: (response, handler) {
          print('✅ RESPONSE: ${response.statusCode}');
          return handler.next(response);
        },

        onError: (DioException e, handler) {
          print('❌ ERROR: ${e.message}');

          if (e.type == DioExceptionType.connectionError) {
            print("No Internet or DNS issue");
          } else if (e.type == DioExceptionType.badResponse) {
            print("Server error: ${e.response?.statusCode}");
          }

          return handler.next(e);
        },
      ),
    );
  }

  Dio get dio => _dio;
}
