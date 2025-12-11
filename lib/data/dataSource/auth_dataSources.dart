import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:quickmed/core/network/api_client.dart';


import '../../core/endpoint/api_endpoints.dart';
import '../models/request/register_request.dart';
import '../models/response/register_response.dart';

/// Authentication Data Source
/// Handles all authentication-related API calls
class AuthDataSource {

  final ApiClient apiClient;

  // Constructor injection
  AuthDataSource({required this.apiClient});
  /// Throws [Exception] on failure
  Future<RegisterResponse> register(RegisterRequest request) async {
    try {
      if (kDebugMode) {
        print('📝 Registering user: ${request.email}');
      }

      final response = await apiClient.post(
        endpoint: ApiEndpoints.register,
        data: request.toJson(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (kDebugMode) {
          print('✅ Registration successful: ${response.data}');
        }

        return RegisterResponse.fromJson(response.data);
      } else {
        // Handle error response
        final errorMessage = response.data['message'] ??
            response.data['error'] ??
            'Registration failed';

        if (kDebugMode) {
          print('❌ Registration failed: $errorMessage');
        }

        throw Exception(errorMessage);
      }
    } on DioException catch (e) {
      if (kDebugMode) {
        print('❌ DioException during registration: ${e.message}');
      }

      // Extract error message from response
      if (e.response?.data != null) {
        final errorData = e.response!.data;
        final errorMessage = errorData['message'] ??
            errorData['error'] ??
            'Registration failed';
        throw Exception(errorMessage);
      }

      throw Exception('Network error: ${e.message}');
    } catch (e) {
      if (kDebugMode) {
        print('❌ Unexpected error during registration: $e');
      }
      throw Exception('Registration failed: $e');
    }
  }




}