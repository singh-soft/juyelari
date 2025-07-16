import 'package:dio/dio.dart';
import 'package:juyelari/Features/provider/auth.dart';
import 'package:juyelari/Features/res/routes/base_url/base_url.dart';

class ApiProvider {
final Dio _dio = Dio(
  BaseOptions(
    baseUrl: appBaseUrl,
    connectTimeout: const Duration(seconds: 20),
    receiveTimeout: const Duration(seconds: 30),
    sendTimeout: const Duration(seconds: 30),
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
  final String authToken = await token(); 
  try {
    final response = await _dio.post(
      apiUrl,
      data: data,
      options: Options(
        headers: {
          'Authorization': 'Bearer $authToken',
          'Content-Type': 'application/json',
        },
      ),
    );
    return _handleResponse(response);
  } on DioException catch (e) {
    if (e.response != null) {
      return _handleResponse(e.response!);
    } else {
      rethrow;
    }
  }
}

  // dynamic _handleResponse(Response response) {
  //   if ([200, 201, 400, 422].contains(response.statusCode)) {
  //     return response.data;
  //   } else if (response.statusCode == 401) {
  //     return Future.error('Unauthorized');
  //   } else if (response.statusCode == 404) {
  //     return Future.error('Resource not found');
  //   } else {
  //     return Future.error('Unexpected error: ${response.statusCode}');
  //   }
  // }
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
  final statusCode = response.statusCode;

  if (statusCode == 200 || statusCode == 201 || statusCode == 400 || statusCode == 422||statusCode == 404) {
    return response.data;
  } else if (statusCode == 401) {
    return Future.error('Unauthorized access');
  } else if (statusCode == 404) {
    return Future.error('Resource not found');
  } else if (statusCode == 500) {
    return Future.error('Internal server error');
  } else {
    return Future.error('Unexpected error: $statusCode\n${response.data}');
  }
}

