// lib/features/booking/data/datasources/booking_data_source.dart
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import '../../../../core/network/api_client.dart';
import '../../core/endpoint/api_endpoints.dart';
import '../models/request/BookingRequest.dart';
import '../models/response/BookingResponse.dart';

class BookingDataSource {
  final ApiClient apiClient;

  BookingDataSource({required this.apiClient});

  /// Create a new booking
  /// Throws [Exception] on failure
  Future<BookingResponse> createBooking(BookingRequest request) async {
    try {
      if (kDebugMode) {
        print('📝 Creating booking for doctor: ${request.doctorId}');
        print('📦 Request data: ${request.toJson()}');
      }

      final response = await apiClient.post(
        endpoint: ApiEndpoints.bookings,
        data: request.toJson(),
      );

      if (kDebugMode) {
        print('📥 Response status: ${response.statusCode}');
        print('📥 Response data: ${response.data}');
      }

      // SUCCESS CASE
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (kDebugMode) print('✅ Booking created successfully');

        if (response.data is! Map<String, dynamic>) {
          throw Exception("Invalid response format from server");
        }

        return BookingResponse.fromJson(response.data);
      }

      // ERROR CASE
      return _extractErrorAndThrow(response.data, response.statusCode);

    } on DioException catch (e) {
      if (kDebugMode) {
        print('❌ DioException during booking creation: ${e.message}');
        print('❌ Response status: ${e.response?.statusCode}');
        print('❌ Response data: ${e.response?.data}');
      }

      if (e.response?.data != null) {
        return _extractErrorAndThrow(e.response!.data, e.response!.statusCode);
      }

      throw Exception('Network error: ${e.message}');
    } catch (e) {
      if (kDebugMode) print('❌ Unexpected error during booking: $e');
      throw Exception('Booking failed: $e');
    }
  }

  /// Get all bookings
  Future<List<BookingResponse>> getBookings() async {
    try {
      if (kDebugMode) print('📋 Fetching all bookings');

      final response = await apiClient.get(
      ApiEndpoints.bookings,
      );

      if (kDebugMode) {
        print('📥 Response status: ${response.statusCode}');
        print('📥 Response data: ${response.data}');
      }

      if (response.statusCode == 200) {
        if (response.data is! List) {
          throw Exception("Invalid response format - expected list");
        }

        final bookings = (response.data as List)
            .map((json) => BookingResponse.fromJson(json as Map<String, dynamic>))
            .toList();

        if (kDebugMode) print('✅ Fetched ${bookings.length} bookings');
        return bookings;
      }

      throw Exception('Failed to fetch bookings: ${response.statusCode}');

    } on DioException catch (e) {
      if (kDebugMode) {
        print('❌ DioException during fetching bookings: ${e.message}');
      }
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      if (kDebugMode) print('❌ Unexpected error: $e');
      throw Exception('Failed to fetch bookings: $e');
    }
  }

  /// Get booking by ID
  Future<BookingResponse> getBookingById(int id) async {
    try {
      if (kDebugMode) print('🔍 Fetching booking with ID: $id');

      final response = await apiClient.get(ApiEndpoints.bookingById(id),
      );

      if (response.statusCode == 200) {
        if (response.data is! Map<String, dynamic>) {
          throw Exception("Invalid response format");
        }

        return BookingResponse.fromJson(response.data);
      }

      throw Exception('Failed to fetch booking: ${response.statusCode}');

    } on DioException catch (e) {
      if (kDebugMode) print('❌ DioException: ${e.message}');
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      if (kDebugMode) print('❌ Unexpected error: $e');
      throw Exception('Failed to fetch booking: $e');
    }
  }
  Future<List<BookingResponse>> getPatientBookings() async {
    try {
      if (kDebugMode) print('👤 Fetching patient bookings');

      final response = await apiClient.get(
         ApiEndpoints.patientBookings,
      );

      if (kDebugMode) {
        print('📥 Response status: ${response.statusCode}');
        print('📥 Response data: ${response.data}');
      }

      if (response.statusCode == 200) {
        if (response.data is! List) {
          throw Exception("Invalid response format - expected list");
        }

        final bookings = (response.data as List)
            .map((json) => BookingResponse.fromJson(json as Map<String, dynamic>))
            .toList();

        if (kDebugMode) print('✅ Fetched ${bookings.length} patient bookings');
        return bookings;
      }

      throw Exception('Failed to fetch patient bookings: ${response.statusCode}');

    } on DioException catch (e) {
      if (kDebugMode) {
        print('❌ DioException during fetching patient bookings: ${e.message}');
        print('❌ Response status: ${e.response?.statusCode}');
        print('❌ Response data: ${e.response?.data}');
      }

      if (e.response?.data != null) {
        return _extractErrorAndThrow(e.response!.data, e.response!.statusCode);
      }

      throw Exception('Network error: ${e.message}');
    } catch (e) {
      if (kDebugMode) print('❌ Unexpected error: $e');
      throw Exception('Failed to fetch patient bookings: $e');
    }
  }

  // Helper method to extract error messages
  Never _extractErrorAndThrow(dynamic data, int? statusCode) {
    if (kDebugMode) {
      print('❌ Error response (status $statusCode): $data');
    }

    String errorMessage = 'Booking failed';

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