// import 'dart:io';
//
// import 'package:dio/dio.dart';
// import 'package:flutter/foundation.dart';
//
// class ApiClient {
//   final Dio _dio;
//
//   ApiClient(String baseUrl)
//       : _dio = Dio(BaseOptions(
//     baseUrl: baseUrl,
//     connectTimeout: const Duration(seconds: 10),
//     receiveTimeout: const Duration(seconds: 10),
//     headers: {
//       'Content-Type': 'application/json',
//       'Accept': 'application/json', // ✅ Added Accept header
//     },
//   )) {
//     _dio.interceptors.add(
//       InterceptorsWrapper(
//         onRequest: (options, handler) async {
//           if (kDebugMode) {
//             print('📤 Request: ${options.method} ${options.path}');
//             print('📤 Headers: ${options.headers}');
//             print('📤 Data: ${options.data}');
//           }
//           handler.next(options);
//         },
//         onResponse: (response, handler) {
//           if (kDebugMode) {
//             print('✅ Response [${response.statusCode}]: ${response.requestOptions.path}');
//             print('✅ Response data: ${response.data}');
//           }
//           handler.next(response);
//         },
//         onError: (error, handler) {
//           if (kDebugMode) {
//             print('❌ Error [${error.response?.statusCode}]: ${error.message}');
//             print('❌ Error data: ${error.response?.data}');
//           }
//           handler.next(error);
//         },
//       ),
//     );
//   }
//
//   // GET request
//   Future<Response> get(
//       String endpoint, {
//         Map<String, dynamic>? queryParameters,
//         Map<String, dynamic>? headers,
//       }) async {
//     try {
//       final response = await _dio.get(
//         endpoint,
//         queryParameters: queryParameters,
//         options: headers != null ? Options(headers: headers) : null,
//       );
//       return response;
//     } on DioException catch (e) {
//       return _handleError(e);
//     }
//   }
//
//   // POST request
//   Future<Response> post({
//     required String endpoint,
//     dynamic data,
//     Map<String, dynamic>? headers,
//   }) async {
//     try {
//       // ✅ FIX: Dio automatically handles JSON encoding for Map<String, dynamic>
//       // Don't manually jsonEncode - just pass the Map
//       final response = await _dio.post(
//         endpoint,
//         data: data, // ✅ Dio will automatically encode this if it's a Map
//         options: Options(
//           headers: headers,
//           validateStatus: (status) => true, // Handle all status codes manually
//         ),
//       );
//       return response;
//     } on DioException catch (e) {
//       return _handleError(e);
//     }
//   }
//
//   // PUT request
//   Future<Response> put({
//     required String endpoint,
//     required Map<String, dynamic> data,
//     bool isFormData = false,
//   }) async {
//     try {
//       if (isFormData) {
//         // Convert data to FormData
//         final formData = await _convertToFormData(data);
//
//         return await _dio.put(
//           endpoint,
//           data: formData,
//           options: Options(
//             contentType: 'multipart/form-data',
//           ),
//         );
//       } else {
//         // Regular JSON request
//         return await _dio.put(
//           endpoint,
//           data: data,
//         );
//       }
//     } catch (e) {
//       rethrow;
//     }
//   }
//
//   Future<FormData> _convertToFormData(Map<String, dynamic> data) async {
//     final formDataMap = <String, dynamic>{};
//
//     for (var entry in data.entries) {
//       final key = entry.key;
//       final value = entry.value;
//
//       if (value is File) {
//         // Handle File object
//         final fileName = value.path.split('/').last;
//         formDataMap[key] = await MultipartFile.fromFile(
//           value.path,
//           filename: fileName,
//         );
//       } else if (value is String && (value.startsWith('/') || value.contains('file://'))) {
//         // Handle file path string
//         final filePath = value.replaceAll('file://', '');
//         final fileName = filePath.split('/').last;
//         formDataMap[key] = await MultipartFile.fromFile(
//           filePath,
//           filename: fileName,
//         );
//       } else if (value is MultipartFile) {
//         // Already a MultipartFile
//         formDataMap[key] = value;
//       } else {
//         // Regular data (string, int, etc.)
//         formDataMap[key] = value;
//       }
//     }
//
//     return FormData.fromMap(formDataMap);
//   }
//
//   // DELETE request
//   Future<Response> delete({
//     required String endpoint,
//     Map<String, dynamic>? data,
//     Map<String, dynamic>? headers,
//   }) async {
//     try {
//       final response = await _dio.delete(
//         endpoint,
//         data: data,
//         options: headers != null ? Options(headers: headers) : null,
//       );
//       return response;
//     } on DioException catch (e) {
//       return _handleError(e);
//     }
//   }
//
//   // PATCH request
//   Future<Response> patch(
//       String path, {
//         Map<String, dynamic>? data,
//         Map<String, dynamic>? queryParameters,
//         Options? options,
//       }) async {
//     try {
//       final response = await _dio.patch(
//         path,
//         data: data,
//         queryParameters: queryParameters,
//         options: options,
//       );
//       return response;
//     } on DioException catch (e) {
//       return _handleError(e);
//     }
//   }
//
//   // Multipart POST (file uploads)
//   Future<Response> postMultipart({
//     required String endpoint,
//     required FormData data,
//   }) async {
//     try {
//       final response = await _dio.post(
//         endpoint,
//         data: data,
//         options: Options(
//           contentType: 'multipart/form-data',
//         ),
//       );
//       return response;
//     } on DioException catch (e) {
//       return _handleError(e);
//     }
//   }
//
//   // Multipart PUT
//   Future<Response> putMultipart({
//     required String endpoint,
//     required FormData data,
//   }) async {
//     try {
//       final response = await _dio.put(
//         endpoint,
//         data: data,
//         options: Options(
//           headers: {
//             'Content-Type': 'multipart/form-data',
//           },
//         ),
//       );
//       return response;
//     } on DioException catch (e) {
//       return _handleError(e);
//     }
//   }
//
//   // Error handling
//   Response _handleError(DioException error) {
//     switch (error.type) {
//       case DioExceptionType.connectionTimeout:
//         if (kDebugMode) print("⏱️ Connection Timeout: ${error.message}");
//         break;
//       case DioExceptionType.sendTimeout:
//         if (kDebugMode) print("⏱️ Send Timeout: ${error.message}");
//         break;
//       case DioExceptionType.receiveTimeout:
//         if (kDebugMode) print("⏱️ Receive Timeout: ${error.message}");
//         break;
//       case DioExceptionType.badResponse:
//         if (kDebugMode) print("❌ Bad Response [${error.response?.statusCode}]: ${error.response?.data}");
//         return error.response!;
//       case DioExceptionType.cancel:
//         if (kDebugMode) print("🚫 Request Cancelled: ${error.message}");
//         break;
//       case DioExceptionType.badCertificate:
//         if (kDebugMode) print("🔒 Bad Certificate: ${error.message}");
//         break;
//       case DioExceptionType.connectionError:
//         if (kDebugMode) print("🌐 Connection Error: ${error.message}");
//         break;
//       case DioExceptionType.unknown:
//         if (kDebugMode) print("❓ Unknown Error: ${error.message}");
//         break;
//     }
//
//     return error.response ??
//         Response(
//           requestOptions: RequestOptions(path: error.requestOptions.path),
//           statusCode: 500,
//           statusMessage: 'An unknown error occurred.',
//         );
//   }
// }


import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../../data/local/UserPreferences.dart';

class ApiClient {
  final Dio _dio;
  final UserPreferences _userPrefs;

  ApiClient(String baseUrl, {UserPreferences? userPrefs})
      : _userPrefs = userPrefs ?? UserPreferences(),
        _dio = Dio(BaseOptions(
          baseUrl: baseUrl,
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        )) {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // ✅ Automatically add token to requests
          final token = await _userPrefs.getToken();
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
            if (kDebugMode) print('🔑 Token added to request');
          }

          if (kDebugMode) {
            print('📤 Request: ${options.method} ${options.path}');
            print('📤 Headers: ${options.headers}');
            print('📤 Data: ${options.data}');
          }
          handler.next(options);
        },
        onResponse: (response, handler) {
          if (kDebugMode) {
            print('✅ Response [${response.statusCode}]: ${response.requestOptions.path}');
            print('✅ Response data: ${response.data}');
          }
          handler.next(response);
        },
        onError: (error, handler) async {
          if (kDebugMode) {
            print('❌ Error [${error.response?.statusCode}]: ${error.message}');
            print('❌ Error data: ${error.response?.data}');
          }

          // ✅ Handle 401 - Clear session
          if (error.response?.statusCode == 401) {
            if (kDebugMode) print('🔓 Unauthorized - Clearing session');
            await _userPrefs.clearUserData();
          }

          handler.next(error);
        },
      ),
    );
  }

  // GET request
  Future<Response> get(
      String endpoint, {
        Map<String, dynamic>? queryParameters,
        Map<String, dynamic>? headers,
      }) async {
    try {
      final response = await _dio.get(
        endpoint,
        queryParameters: queryParameters,
        options: headers != null ? Options(headers: headers) : null,
      );
      return response;
    } on DioException catch (e) {
      return _handleError(e);
    }
  }

  // POST request
  Future<Response> post({
    required String endpoint,
    dynamic data,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await _dio.post(
        endpoint,
        data: data,
        options: Options(
          headers: headers,
          validateStatus: (status) => true,
        ),
      );
      return response;
    } on DioException catch (e) {
      return _handleError(e);
    }
  }

  // PUT request
  Future<Response> put({
    required String endpoint,
    required Map<String, dynamic> data,
    bool isFormData = false,
  }) async {
    try {
      if (isFormData) {
        final formData = await _convertToFormData(data);
        return await _dio.put(
          endpoint,
          data: formData,
          options: Options(
            contentType: 'multipart/form-data',
          ),
        );
      } else {
        return await _dio.put(
          endpoint,
          data: data,
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<FormData> _convertToFormData(Map<String, dynamic> data) async {
    final formDataMap = <String, dynamic>{};

    for (var entry in data.entries) {
      final key = entry.key;
      final value = entry.value;

      if (value is File) {
        final fileName = value.path.split('/').last;
        formDataMap[key] = await MultipartFile.fromFile(
          value.path,
          filename: fileName,
        );
      } else if (value is String && (value.startsWith('/') || value.contains('file://'))) {
        final filePath = value.replaceAll('file://', '');
        final fileName = filePath.split('/').last;
        formDataMap[key] = await MultipartFile.fromFile(
          filePath,
          filename: fileName,
        );
      } else if (value is MultipartFile) {
        formDataMap[key] = value;
      } else {
        formDataMap[key] = value;
      }
    }

    return FormData.fromMap(formDataMap);
  }

  // DELETE request
  Future<Response> delete({
    required String endpoint,
    Map<String, dynamic>? data,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await _dio.delete(
        endpoint,
        data: data,
        options: headers != null ? Options(headers: headers) : null,
      );
      return response;
    } on DioException catch (e) {
      return _handleError(e);
    }
  }

  // PATCH request
  Future<Response> patch(
      String path, {
        Map<String, dynamic>? data,
        Map<String, dynamic>? queryParameters,
        Options? options,
      }) async {
    try {
      final response = await _dio.patch(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return response;
    } on DioException catch (e) {
      return _handleError(e);
    }
  }

  // Multipart POST (file uploads)
  Future<Response> postMultipart({
    required String endpoint,
    required FormData data,
  }) async {
    try {
      final response = await _dio.post(
        endpoint,
        data: data,
        options: Options(
          contentType: 'multipart/form-data',
        ),
      );
      return response;
    } on DioException catch (e) {
      return _handleError(e);
    }
  }

  // Multipart PUT
  Future<Response> putMultipart({
    required String endpoint,
    required FormData data,
  }) async {
    try {
      final response = await _dio.put(
        endpoint,
        data: data,
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
          },
        ),
      );
      return response;
    } on DioException catch (e) {
      return _handleError(e);
    }
  }

  // Error handling
  Response _handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        if (kDebugMode) print("⏱️ Connection Timeout: ${error.message}");
        break;
      case DioExceptionType.sendTimeout:
        if (kDebugMode) print("⏱️ Send Timeout: ${error.message}");
        break;
      case DioExceptionType.receiveTimeout:
        if (kDebugMode) print("⏱️ Receive Timeout: ${error.message}");
        break;
      case DioExceptionType.badResponse:
        if (kDebugMode) print("❌ Bad Response [${error.response?.statusCode}]: ${error.response?.data}");
        return error.response!;
      case DioExceptionType.cancel:
        if (kDebugMode) print("🚫 Request Cancelled: ${error.message}");
        break;
      case DioExceptionType.badCertificate:
        if (kDebugMode) print("🔒 Bad Certificate: ${error.message}");
        break;
      case DioExceptionType.connectionError:
        if (kDebugMode) print("🌐 Connection Error: ${error.message}");
        break;
      case DioExceptionType.unknown:
        if (kDebugMode) print("❓ Unknown Error: ${error.message}");
        break;
    }

    return error.response ??
        Response(
          requestOptions: RequestOptions(path: error.requestOptions.path),
          statusCode: 500,
          statusMessage: 'An unknown error occurred.',
        );
  }
}