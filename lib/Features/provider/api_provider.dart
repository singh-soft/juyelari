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
      validateStatus: (status) {
        return status != null && status < 500;
      },
    ),
  );

  Future<dynamic> getRequest({required String apiUrl}) async {
    try {
      final response = await _dio.get(apiUrl);

      return _handleResponse(response);
    } on DioException catch (e) {
      if (e.response != null) {
        return _handleResponse(e.response!);
      } else {
        rethrow;
      }
    }
  }

  Future<dynamic> postRequest({
    required String apiUrl,
    Map<String, dynamic> data = const {},
  }) async {
    try {
      final response = await _dio.post(apiUrl, data: data);
      return _handleResponse(response);
    } on DioException catch (e) {
      if (e.response != null) {
        return _handleResponse(e.response!);
      } else {
        rethrow;
      }
    }
  }

  dynamic _handleResponse(Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
      case 400:
        return response.data;
      case 401:
        return Future.error('Unauthorized access');
      case 404:
        return Future.error('Resource not found');
      case 500:
        return Future.error('Internal server error');
      default:
        return Future.error('Unexpected error: ${response.statusCode}');
    }
  }

  String _handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return 'Connection timed out';
      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        if (statusCode == 401) return 'Unauthorized';
        if (statusCode == 404) return 'Not Found';
        if (statusCode == 500) return 'Internal Server Error';
        return 'Server error: $statusCode';
      case DioExceptionType.cancel:
        return 'Request cancelled';
      case DioExceptionType.unknown:
      default:
        return 'Unexpected error: ${e.message}';
    }
  }
}
