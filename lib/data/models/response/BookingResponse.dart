// lib/features/booking/data/models/booking_response.dart
class BookingResponse {
  final int id;
  final String patientName;
  final String doctorName;
  final String medicalHistory;
  final String currentSymptoms;
  final String date;
  final String time;
  final String status;
  final DateTime createdAt;

  BookingResponse({
    required this.id,
    required this.patientName,
    required this.doctorName,
    required this.medicalHistory,
    required this.currentSymptoms,
    required this.date,
    required this.time,
    required this.status,
    required this.createdAt,
  });

  factory BookingResponse.fromJson(Map<String, dynamic> json) {
    return BookingResponse(
      id: json['id'] as int,
      patientName: json['patient_name'] as String,
      doctorName: json['doctor_name'] as String,
      medicalHistory: json['medical_history'] as String,
      currentSymptoms: json['current_symptoms'] as String,
      date: json['date'] as String,
      time: json['time'] as String,
      status: json['status'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'patient_name': patientName,
      'doctor_name': doctorName,
      'medical_history': medicalHistory,
      'current_symptoms': currentSymptoms,
      'date': date,
      'time': time,
      'status': status,
      'created_at': createdAt.toIso8601String(),
    };
  }
}