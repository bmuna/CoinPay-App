import 'package:dio/dio.dart';
import 'logging_interceptor.dart';

class DioClient {
  static Dio? _dio;

  static Dio get dio {
    _dio ??= Dio()
      ..interceptors.add(LoggingInterceptor())
      ..options.baseUrl = 'http://localhost:8081/api'
      ..options.connectTimeout = const Duration(seconds: 30)
      ..options.receiveTimeout = const Duration(seconds: 30)
      ..options.headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };

    return _dio!;
  }
}
