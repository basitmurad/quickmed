class ApiEndpoints{


  static const String baseUrl=  'http://178.128.3.110/api';
  static const String register = '/auth/register/';
  static const String login = '/auth/login/';
  static const String profile = '/auth/profile/';
  static const String bookings = '/bookings';
  static String bookingById(int id) => '/bookings/$id';

  static const String patientBookings = '/bookings/patient-bookings';
  static String deleteBooking(int id) => '/bookings/$id'; //


}