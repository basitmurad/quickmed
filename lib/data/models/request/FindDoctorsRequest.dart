
class FindDoctorsRequest {
  final String symptoms;

  FindDoctorsRequest({
    required this.symptoms,
  });

  Map<String, dynamic> toJson() {
    return {
      'symptoms': symptoms,
    };
  }

  @override
  String toString() {
    return 'FindDoctorsRequest(symptoms: $symptoms)';
  }
}