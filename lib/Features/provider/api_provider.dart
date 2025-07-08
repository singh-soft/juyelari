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
      final response = await _dio.get(apiUrl,
          options: Options(
            headers: {
              'Authorization': 'Bearer ${token().toString()}',
              'Content-Type': 'application/json',
            },
          ));

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
      final response = await _dio.post(apiUrl,
          data: data,
          options: Options(
            headers: {
              'Authorization': 'Bearer ${token().toString()}',
              'Content-Type': 'application/json',
            },
          ));
      return _handleResponse(response);
    } on DioException catch (e) {
      if (e.response != null) {
        return _handleResponse(e.response!);
      } else {
        rethrow;
      }
    }
  }

  // Future<dynamic> postRequest({
  //   required String apiUrl,
  //   Map<String, dynamic> data = const {},
  // }) async {
  //   final String? authToken = await token();

  //   try {
  //     final response = await _dio.post(
  //       apiUrl,
  //       data: data,
  //       options: Options(
  //         headers: {
  //           'Authorization': 'Bearer $authToken',
  //           'Content-Type': 'application/json',
  //         },
  //       ),
  //     );
  //     return _handleResponse(response);
  //   } on DioException catch (e) {
  //     if (e.response != null) {
  //       return _handleResponse(e.response!);
  //     } else {
  //       rethrow;
  //     }
  //   }
  // }

  dynamic _handleResponse(Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
      case 400 || 422:
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
}
