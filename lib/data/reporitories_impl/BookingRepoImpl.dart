// lib/features/booking/data/repositories/booking_repo_impl.dart
import 'package:flutter/foundation.dart';
import '../../domain/repositories/BookingRepository.dart';
import '../dataSource/BookingDataSource.dart';
import '../models/request/BookingRequest.dart';
import '../models/response/BookingResponse.dart';

class BookingRepoImpl implements BookingRepository {
  final BookingDataSource bookingDataSource;

  BookingRepoImpl({required this.bookingDataSource});

  @override
  Future<BookingResponse> createBooking(BookingRequest request) async {
    if (kDebugMode) {
      print("➡️ [BookingRepoImpl] createBooking called with: ${request.toJson()}");
    }

    try {
      final response = await bookingDataSource.createBooking(request);
      if (kDebugMode) {
        print("✅ [BookingRepoImpl] Booking created: ${response.toJson()}");
      }
      return response;
    } catch (error, stackTrace) {
      if (kDebugMode) {
        print("❌ [BookingRepoImpl] Error in createBooking: $error");
        print(stackTrace);
      }
      throw Exception('Error in repository during booking creation: $error');
    }
  }

  @override
  Future<List<BookingResponse>> getBookings() async {
    if (kDebugMode) {
      print("➡️ [BookingRepoImpl] getBookings called");
    }

    try {
      final bookings = await bookingDataSource.getBookings();
      if (kDebugMode) {
        print("✅ [BookingRepoImpl] Fetched ${bookings.length} bookings");
      }
      return bookings;
    } catch (error, stackTrace) {
      if (kDebugMode) {
        print("❌ [BookingRepoImpl] Error in getBookings: $error");
        print(stackTrace);
      }
      throw Exception('Error in repository while fetching bookings: $error');
    }
  }

  @override
  Future<List<BookingResponse>> getPatientBookings() async {
    if (kDebugMode) {
      print("➡️ [BookingRepoImpl] getPatientBookings called");
    }

    try {
      final bookings = await bookingDataSource.getPatientBookings();
      if (kDebugMode) {
        print("✅ [BookingRepoImpl] Fetched ${bookings.length} patient bookings");
      }
      return bookings;
    } catch (error, stackTrace) {
      if (kDebugMode) {
        print("❌ [BookingRepoImpl] Error in getPatientBookings: $error");
        print(stackTrace);
      }
      throw Exception('Error in repository while fetching patient bookings: $error');
    }
  }

  @override
  Future<BookingResponse> getBookingById(int id) async {
    if (kDebugMode) {
      print("➡️ [BookingRepoImpl] getBookingById called with ID: $id");
    }

    try {
      final booking = await bookingDataSource.getBookingById(id);
      if (kDebugMode) {
        print("✅ [BookingRepoImpl] Fetched booking: ${booking.toJson()}");
      }
      return booking;
    } catch (error, stackTrace) {
      if (kDebugMode) {
        print("❌ [BookingRepoImpl] Error in getBookingById: $error");
        print(stackTrace);
      }
      throw Exception('Error in repository while fetching booking: $error');
    }
  }


}