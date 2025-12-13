// lib/features/doctors/data/repositories/doctor_repository_impl.dart

import 'package:flutter/foundation.dart';
import '../../domain/repositories/DoctorRepository.dart';
import '../dataSource/DoctorDataSource.dart';
import '../models/request/FindDoctorsRequest.dart';
import '../models/response/FindDoctorsResponse.dart';

class DoctorRepositoryImpl implements DoctorRepository {
  final DoctorDataSource doctorDataSource;

  DoctorRepositoryImpl({required this.doctorDataSource});

  @override
  Future<FindDoctorsResponse> findDoctors(FindDoctorsRequest request) async {
    if (kDebugMode) {
      print("➡️ [DoctorRepoImpl] findDoctors called with: ${request.toJson()}");
    }

    try {
      final response = await doctorDataSource.findDoctors(request);

      if (kDebugMode) {
        print("✅ [DoctorRepoImpl] Find doctors success: ${response.count} doctors found");
      }

      return response;
    } catch (error, stackTrace) {
      if (kDebugMode) {
        print("❌ [DoctorRepoImpl] Error in findDoctors: $error");
        print(stackTrace);
      }
      throw Exception('Error in repository during doctor search: $error');
    }
  }
}