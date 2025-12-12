// lib/features/booking/presentation/providers/booking_provider.dart
import 'package:flutter/foundation.dart';

import '../../data/models/request/BookingRequest.dart';
import '../../data/models/response/BookingResponse.dart';
import '../../domain/repositories/BookingRepository.dart';


enum BookingStatus {
  initial,
  loading,
  success,
  error,
}

class BookingProvider extends ChangeNotifier {
  final BookingRepository bookingRepository;

  BookingProvider({required this.bookingRepository});

  // State
  BookingStatus _status = BookingStatus.initial;
  String? _errorMessage;
  BookingResponse? _currentBooking;
  List<BookingResponse> _bookings = [];
  List<BookingResponse> _patientBookings = [];

  // Getters
  BookingStatus get status => _status;
  String? get errorMessage => _errorMessage;
  BookingResponse? get currentBooking => _currentBooking;
  List<BookingResponse> get bookings => _bookings;
  List<BookingResponse> get patientBookings => _patientBookings;
  bool get isLoading => _status == BookingStatus.loading;
  bool get hasError => _status == BookingStatus.error;

  // Private setter methods
  void _setLoading() {
    _status = BookingStatus.loading;
    _errorMessage = null;
    notifyListeners();
  }

  void _setSuccess() {
    _status = BookingStatus.success;
    _errorMessage = null;
    notifyListeners();
  }

  void _setError(String message) {
    _status = BookingStatus.error;
    _errorMessage = message;
    notifyListeners();
  }

  /// Create a new booking
  Future<bool> createBooking(BookingRequest request) async {
    if (kDebugMode) {
      print('📝 [BookingProvider] Creating booking: ${request.toJson()}');
    }

    _setLoading();

    try {
      final response = await bookingRepository.createBooking(request);
      _currentBooking = response;
      _setSuccess();

      if (kDebugMode) {
        print('✅ [BookingProvider] Booking created: ${response.toJson()}');
      }

      return true;
    } catch (error) {
      if (kDebugMode) {
        print('❌ [BookingProvider] Error creating booking: $error');
      }
      _setError(error.toString());
      return false;
    }
  }

  /// Fetch all bookings
  Future<void> fetchBookings() async {
    if (kDebugMode) {
      print('📋 [BookingProvider] Fetching all bookings');
    }

    _setLoading();

    try {
      final bookings = await bookingRepository.getBookings();
      _bookings = bookings;
      _setSuccess();

      if (kDebugMode) {
        print('✅ [BookingProvider] Fetched ${bookings.length} bookings');
      }
    } catch (error) {
      if (kDebugMode) {
        print('❌ [BookingProvider] Error fetching bookings: $error');
      }
      _setError(error.toString());
    }
  }

  /// Fetch patient's own bookings
  Future<void> fetchPatientBookings() async {
    if (kDebugMode) {
      print('👤 [BookingProvider] Fetching patient bookings');
    }

    _setLoading();

    try {
      final bookings = await bookingRepository.getPatientBookings();
      _patientBookings = bookings;
      _setSuccess();

      if (kDebugMode) {
        print('✅ [BookingProvider] Fetched ${bookings.length} patient bookings');
      }
    } catch (error) {
      if (kDebugMode) {
        print('❌ [BookingProvider] Error fetching patient bookings: $error');
      }
      _setError(error.toString());
    }
  }

  /// Fetch booking by ID
  Future<void> fetchBookingById(int id) async {
    if (kDebugMode) {
      print('🔍 [BookingProvider] Fetching booking with ID: $id');
    }

    _setLoading();

    try {
      final booking = await bookingRepository.getBookingById(id);
      _currentBooking = booking;
      _setSuccess();

      if (kDebugMode) {
        print('✅ [BookingProvider] Fetched booking: ${booking.toJson()}');
      }
    } catch (error) {
      if (kDebugMode) {
        print('❌ [BookingProvider] Error fetching booking: $error');
      }
      _setError(error.toString());
    }
  }

  /// Delete a booking
  // Future<bool> deleteBooking(int id) async {
  //   if (kDebugMode) {
  //     print('🗑️ [BookingProvider] Deleting booking with ID: $id');
  //   }
  //
  //   _setLoading();
  //
  //   try {
  //     await bookingRepository.de(id);
  //
  //     // Remove from local lists
  //     _bookings.removeWhere((booking) => booking.id == id);
  //     _patientBookings.removeWhere((booking) => booking.id == id);
  //
  //     _setSuccess();
  //
  //     if (kDebugMode) {
  //       print('✅ [BookingProvider] Booking deleted successfully');
  //     }
  //
  //     return true;
  //   } catch (error) {
  //     if (kDebugMode) {
  //       print('❌ [BookingProvider] Error deleting booking: $error');
  //     }
  //     _setError(error.toString());
  //     return false;
  //   }
  // }

  /// Reset provider state
  void reset() {
    _status = BookingStatus.initial;
    _errorMessage = null;
    _currentBooking = null;
    _bookings = [];
    _patientBookings = [];
    notifyListeners();
  }

  /// Clear error
  void clearError() {
    _errorMessage = null;
    if (_status == BookingStatus.error) {
      _status = BookingStatus.initial;
    }
    notifyListeners();
  }
}