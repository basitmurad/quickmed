// lib/features/doctors/domain/repositories/doctor_repository.dart

import '../../data/models/request/FindDoctorsRequest.dart';
import '../../data/models/response/FindDoctorsResponse.dart';

abstract class DoctorRepository {
  /// Find doctors based on symptoms
  /// Returns [FindDoctorsResponse] on success
  /// Throws [Exception] on failure
  Future<FindDoctorsResponse> findDoctors(FindDoctorsRequest request);
}