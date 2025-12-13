// lib/features/doctors/data/datasources/doctor_data_source.dart

import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import '../../../../core/network/api_client.dart';
import '../../core/endpoint/api_endpoints.dart';
import '../models/models/DoctorModel.dart';
import '../models/request/FindDoctorsRequest.dart';
import '../models/response/FindDoctorsResponse.dart';

class DoctorDataSource {
  final ApiClient apiClient;

  DoctorDataSource({required this.apiClient});

  /// Find doctors based on symptoms
  /// Throws [Exception] on failure
  Future<FindDoctorsResponse> findDoctors(FindDoctorsRequest request) async {
    try {
      if (kDebugMode) {
        print('🔍 Searching doctors for symptoms: ${request.symptoms}');
        print('📦 Request data: ${request.toJson()}');
      }

      final response = await apiClient.post(
        endpoint: ApiEndpoints.findDoctors,
        data: request.toJson(),
      );

      if (kDebugMode) {
        print('📥 Response status: ${response.statusCode}');
        print('📥 Response data: ${response.data}');
      }

      // SUCCESS CASE
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (kDebugMode) print('✅ Doctors found successfully');

        if (response.data is! Map<String, dynamic>) {
          throw Exception("Invalid response format from server");
        }

        final doctorsResponse = FindDoctorsResponse.fromJson(response.data);

        if (kDebugMode) {
          print('✅ Found ${doctorsResponse.count} doctors matching symptoms');
        }

        return doctorsResponse;
      }

      // ERROR CASE
      return _extractErrorAndThrow(response.data, response.statusCode);

    } on DioException catch (e) {
      if (kDebugMode) {
        print('❌ DioException during doctor search: ${e.message}');
        print('❌ Response status: ${e.response?.statusCode}');
        print('❌ Response data: ${e.response?.data}');
      }

      if (e.response?.data != null) {
        return _extractErrorAndThrow(e.response!.data, e.response!.statusCode);
      }

      throw Exception('Network error: ${e.message}');
    } catch (e) {
      if (kDebugMode) print('❌ Unexpected error during doctor search: $e');
      throw Exception('Doctor search failed: $e');
    }
  }



  // Helper method to extract error messages
  Never _extractErrorAndThrow(dynamic data, int? statusCode) {
    if (kDebugMode) {
      print('❌ Error response (status $statusCode): $data');
    }

    String errorMessage = 'Doctor search failed';

    if (data is Map<String, dynamic>) {
      errorMessage = data['message'] ??
          data['error'] ??
          data['detail'] ??
          errorMessage;
    } else if (data is String) {
      errorMessage = data;
    }

    throw Exception(errorMessage);
  }
}