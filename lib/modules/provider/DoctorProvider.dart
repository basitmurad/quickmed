//
// import 'package:flutter/foundation.dart';
// import '../../data/models/models/DoctorModel.dart';
// import '../../data/models/request/FindDoctorsRequest.dart';
// import '../../domain/repositories/DoctorRepository.dart';
//
// enum DoctorSearchStatus {
//   initial,
//   loading,
//   success,
//   error,
// }
//
// class DoctorProvider extends ChangeNotifier {
//   final DoctorRepository doctorRepository;
//
//   DoctorProvider({required this.doctorRepository});
//
//   // State variables
//   DoctorSearchStatus _status = DoctorSearchStatus.initial;
//   List<DoctorModel> _doctors = [];
//   String? _errorMessage;
//   int _totalCount = 0;
//
//   // Getters
//   DoctorSearchStatus get status => _status;
//   List<DoctorModel> get doctors => _doctors;
//   String? get errorMessage => _errorMessage;
//   int get totalCount => _totalCount;
//   bool get isLoading => _status == DoctorSearchStatus.loading;
//   bool get hasError => _status == DoctorSearchStatus.error;
//   bool get hasData => _status == DoctorSearchStatus.success;
//
//   /// Find doctors based on symptoms
//   Future<void> findDoctors(String symptoms) async {
//     if (kDebugMode) {
//       print('🔍 [DoctorProvider] Finding doctors for symptoms: $symptoms');
//     }
//
//     _status = DoctorSearchStatus.loading;
//     _errorMessage = null;
//     notifyListeners();
//
//     try {
//       final request = FindDoctorsRequest(symptoms: symptoms);
//       final response = await doctorRepository.findDoctors(request);
//
//       _doctors = response.doctors;
//       _totalCount = response.count;
//       _status = DoctorSearchStatus.success;
//       _errorMessage = null;
//
//       if (kDebugMode) {
//         print('✅ [DoctorProvider] Found ${_doctors.length} doctors');
//       }
//
//       notifyListeners();
//     } catch (error) {
//       _status = DoctorSearchStatus.error;
//       _errorMessage = error.toString().replaceAll('Exception: ', '');
//       _doctors = [];
//       _totalCount = 0;
//
//       if (kDebugMode) {
//         print('❌ [DoctorProvider] Error finding doctors: $error');
//       }
//
//       notifyListeners();
//     }
//   }
//
//   /// Clear search results and reset state
//   void clearSearch() {
//     if (kDebugMode) {
//       print('🧹 [DoctorProvider] Clearing search results');
//     }
//
//     _status = DoctorSearchStatus.initial;
//     _doctors = [];
//     _totalCount = 0;
//     _errorMessage = null;
//     notifyListeners();
//   }
//
//   /// Reset error state
//   void clearError() {
//     if (kDebugMode) {
//       print('🧹 [DoctorProvider] Clearing error state');
//     }
//
//     _errorMessage = null;
//     if (_status == DoctorSearchStatus.error) {
//       _status = DoctorSearchStatus.initial;
//     }
//     notifyListeners();
//   }
// }



import 'package:flutter/foundation.dart';
import '../../data/models/models/DoctorModel.dart';
import '../../data/models/request/FindDoctorsRequest.dart';
import '../../domain/repositories/DoctorRepository.dart';

enum DoctorSearchStatus {
  initial,
  loading,
  success,
  error,
}

class DoctorProvider extends ChangeNotifier {
  final DoctorRepository doctorRepository;

  DoctorProvider({required this.doctorRepository});

  // State variables
  DoctorSearchStatus _status = DoctorSearchStatus.initial;
  List<DoctorModel> _doctors = [];
  String? _errorMessage;
  int _totalCount = 0;
  String? _selectedDoctorId;

  // Getters
  DoctorSearchStatus get status => _status;
  List<DoctorModel> get doctors => _doctors;
  List<DoctorModel> get suggestedDoctors => _doctors; // Alias for UI compatibility
  String? get errorMessage => _errorMessage;
  int get totalCount => _totalCount;
  bool get isLoading => _status == DoctorSearchStatus.loading;
  bool get hasError => _status == DoctorSearchStatus.error;
  bool get hasData => _status == DoctorSearchStatus.success;
  String? get selectedDoctorId => _selectedDoctorId;

  // Get selected doctor object
  DoctorModel? get selectedDoctor {
    if (_selectedDoctorId == null) return null;
    try {
      return _doctors.firstWhere((doctor) => doctor.id == _selectedDoctorId);
    } catch (e) {
      return null;
    }
  }

  /// Find doctors based on symptoms
  Future<void> findDoctors(String symptoms) async {
    if (kDebugMode) {
      print('🔍 [DoctorProvider] Finding doctors for symptoms: $symptoms');
    }

    _status = DoctorSearchStatus.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      final request = FindDoctorsRequest(symptoms: symptoms);
      final response = await doctorRepository.findDoctors(request);

      _doctors = response.doctors;
      _totalCount = response.count;
      _status = DoctorSearchStatus.success;
      _errorMessage = null;

      if (kDebugMode) {
        print('✅ [DoctorProvider] Found ${_doctors.length} doctors');
      }

      notifyListeners();
    } catch (error) {
      _status = DoctorSearchStatus.error;
      _errorMessage = error.toString().replaceAll('Exception: ', '');
      _doctors = [];
      _totalCount = 0;

      if (kDebugMode) {
        print('❌ [DoctorProvider] Error finding doctors: $error');
      }

      notifyListeners();
    }
  }

  /// Select a doctor by ID
  void selectDoctor(String doctorId) {
    if (kDebugMode) {
      print('✅ [DoctorProvider] Selecting doctor: $doctorId');
    }

    _selectedDoctorId = doctorId;
    notifyListeners();
  }

  /// Deselect current doctor
  void deselectDoctor() {
    if (kDebugMode) {
      print('❌ [DoctorProvider] Deselecting doctor');
    }

    _selectedDoctorId = null;
    notifyListeners();
  }

  /// Clear search results and reset state
  void clearSearch() {
    if (kDebugMode) {
      print('🧹 [DoctorProvider] Clearing search results');
    }

    _status = DoctorSearchStatus.initial;
    _doctors = [];
    _totalCount = 0;
    _errorMessage = null;
    _selectedDoctorId = null;
    notifyListeners();
  }

  /// Reset error state
  void clearError() {
    if (kDebugMode) {
      print('🧹 [DoctorProvider] Clearing error state');
    }

    _errorMessage = null;
    if (_status == DoctorSearchStatus.error) {
      _status = DoctorSearchStatus.initial;
    }
    notifyListeners();
  }
}