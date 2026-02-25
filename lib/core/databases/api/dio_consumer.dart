import 'package:dio/dio.dart';
import 'package:beautygm/core/databases/api/api_consumer.dart';
import 'package:beautygm/core/databases/api/end_points.dart';
import 'package:beautygm/core/errors/exceptions/dio_exceptions.dart';

class DioConsumer extends ApiConsumer {
  final Dio dio;

  DioConsumer({required this.dio}) {
    dio.options
      ..baseUrl = EndPoints.baseUrl
      ..connectTimeout = const Duration(seconds: 10)
      ..receiveTimeout = const Duration(seconds: 10)
      ..responseType = ResponseType.json;

    dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
        error: true,
      ),
    );
  }

  @override
  Future<dynamic> get(String path,
      {Object? data,
      Map<String, dynamic>? queryParameters,
      Options? options}) async {
    try {
      final response = await dio.get(
        path,
        queryParameters: queryParameters,
        data: data,
        options: options,
      );

      return response.data;
    } on DioException catch (e) {
      handleDioException(e);
    }
  }

  @override
  Future<dynamic> post(String path,
      {Object? data,
      Map<String, dynamic>? queryParameters,
      bool isFormData = false,
      Options? options}) async {
    try {
      final response = await dio.post(
        path,
        data:
            isFormData ? FormData.fromMap(data as Map<String, dynamic>) : data,
        queryParameters: queryParameters,
        options: options,
      );

      return response.data;
    } on DioException catch (e) {
      handleDioException(e);
    }
  }

  @override
  Future<dynamic> patch(String path,
      {Object? data,
      Map<String, dynamic>? queryParameters,
      bool isFormData = false,
      Options? options}) async {
    try {
      final response = await dio.patch(
        path,
        data:
            isFormData ? FormData.fromMap(data as Map<String, dynamic>) : data,
        options: options,
        queryParameters: queryParameters,
      );

      return response.data;
    } on DioException catch (e) {
      handleDioException(e);
    }
  }

  @override
  Future<dynamic> delete(String path,
      {Object? data,
      Map<String, dynamic>? queryParameters,
      bool isFormData = false,
      Options? options}) async {
    try {
      final response = await dio.delete(
        path,
        data: data,
        options: options,
        queryParameters: queryParameters,
      );

      return response.data;
    } on DioException catch (e) {
      handleDioException(e);
    }
  }
}
