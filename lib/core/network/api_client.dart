import 'package:dio/dio.dart';

class ApiClient {
  final Dio _dio;

  ApiClient._(this._dio);

  factory ApiClient(
      {required String baseUrl, Map<String, dynamic>? defaultHeaders}) {
    final BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: defaultHeaders ??
          <String, String>{'Content-Type': 'application/json'},
    );

    final Dio dio = Dio(options);
    
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
        return handler.next(options);
      },
      onResponse:
          (Response<dynamic> response, ResponseInterceptorHandler handler) {
        return handler.next(response);
      },
      onError: (DioException err, ErrorInterceptorHandler handler) {
        return handler.next(err);
      },
    ));

    return ApiClient._(dio);
  }

  Dio get dio => _dio;

  Future<Response<T>> get<T>(String path,
      {Map<String, dynamic>? queryParameters, Options? options}) {
    return _dio.get<T>(path,
        queryParameters: queryParameters, options: options);
  }

  Future<Response<T>> post<T>(String path,
      {dynamic data, Map<String, dynamic>? queryParameters, Options? options}) {
    return _dio.post<T>(path,
        data: data, queryParameters: queryParameters, options: options);
  }

  Future<Response<T>> put<T>(String path,
      {dynamic data, Map<String, dynamic>? queryParameters, Options? options}) {
    return _dio.put<T>(path,
        data: data, queryParameters: queryParameters, options: options);
  }

  Future<Response<T>> delete<T>(String path,
      {dynamic data, Map<String, dynamic>? queryParameters, Options? options}) {
    return _dio.delete<T>(path,
        data: data, queryParameters: queryParameters, options: options);
  }
}
