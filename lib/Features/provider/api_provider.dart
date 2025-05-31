import 'package:dio/dio.dart';
import 'package:juyelari/Features/provider/auth.dart';
import 'package:juyelari/Features/res/routes/base_url/base_url.dart';

class ApiProvider {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: appBaseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        'Authorization': token().toString(),
        'Content-Type': 'application/json',
      },
    ),
  );

  Future<dynamic> getRequest({required String apiUrl}) async {
    try {
      final response = await _dio.get(apiUrl);

      if (response.statusCode == 200) {
        return response.data;
      } else {
        return Future.error(response.data);
      }
    } on DioException catch (e) {
      return Future.error(_handleDioError(e));
    }
  }

      
  Future<dynamic> postRequest({
    required String apiUrl,
    Map<String, dynamic> data = const {},
  }) async {
    try {
      final response = await _dio.post(apiUrl, data: data);

      if (response.statusCode == 200) {
        return response.data;
      } else {
        return Future.error(response.data);
      }
    } on DioException catch (e) {
      return Future.error(_handleDioError(e));
    }
  }

  /// Error handler
  String _handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return 'Connection timed out';
      case DioExceptionType.badResponse:
        return 'Server error: ${e.response?.statusCode}';
      case DioExceptionType.cancel:
        return 'Request cancelled';
      case DioExceptionType.unknown:
      default:
        return 'Unexpected error: ${e.message}';
    }
  }
}
