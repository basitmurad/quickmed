class UserData {
final String id;
final String userType;
final String firstName;
final String lastName;
final String username;
final String email;
final String? dob;
final String? gender;
final String? address;
final String? city;
final String? state;
final String? zipCode;
final String? country;
final String? healthIssues; // For patients
final String? specialization; // For doctors
final String? specializationIllnessSymptoms; // For doctors

UserData({
  required this.id,
  required this.userType,
  required this.firstName,
  required this.lastName,
  required this.username,
  required this.email,
  this.dob,
  this.gender,
  this.address,
  this.city,
  this.state,
  this.zipCode,
  this.country,
  this.healthIssues,
  this.specialization,
  this.specializationIllnessSymptoms,
});

/// Create from JSON
factory UserData.fromJson(Map<String, dynamic> json) {
return UserData(
id: json['id']?.toString() ?? json['_id']?.toString() ?? '',
userType: json['user_type'] ?? '',
firstName: json['first_name'] ?? '',
lastName: json['last_name'] ?? '',
username: json['username'] ?? '',
email: json['email'] ?? '',
dob: json['dob'],
gender: json['gender'],
address: json['address'],
city: json['city'],
state: json['state'],
zipCode: json['zipCode'],
country: json['country'],
healthIssues: json['healthIssues'],
specialization: json['specilization'], // Note: API spelling
specializationIllnessSymptoms: json['specilization_illnes_symptoms'],
);
}

/// Convert to JSON
Map<String, dynamic> toJson() {
return {
'id': id,
'user_type': userType,
'first_name': firstName,
'last_name': lastName,
'username': username,
'email': email,
'dob': dob,
'gender': gender,
'address': address,
'city': city,
'state': state,
'zipCode': zipCode,
'country': country,
'healthIssues': healthIssues,
'specilization': specialization,
'specilization_illnes_symptoms': specializationIllnessSymptoms,
};
}

/// Get full name
String get fullName => '$firstName $lastName';

/// Check if user is a doctor
bool get isDoctor => userType.toLowerCase() == 'doctor';

/// Check if user is a patient
bool get isPatient => userType.toLowerCase() == 'patient';

@override
String toString() {
return 'UserData(id: $id, name: $fullName, email: $email, userType: $userType)';
}
}