

import 'package:go_router/go_router.dart';
import 'package:quickmed/modules/patient/appointment/book_appointment_screen.dart' hide SystemSuggestingDoctorScreen;
import 'package:quickmed/routes/routes.dart';

import '../core/global.dart';
import '../modules/patient/appointment/appointment_success_screen.dart';
import '../modules/patient/appointment/no_available_doctor_screen.dart';
import '../modules/patient/appointment/select_appointment_screen.dart';
import '../modules/patient/appointment/suggested_doctor_screen.dart';
import '../modules/patient/appointment/system_suggesting_doctor_screen.dart';
import '../modules/shared/login/login_screen.dart';
import '../modules/shared/splash/splash_screen.dart';

class AppRouter {
  static final router = GoRouter(
    navigatorKey: navigatorKey,
    debugLogDiagnostics: true,
    initialLocation: '/appointmentSuccessScreen',
    // initialLocation: '/navigationMenu',
    routes: [
      GoRoute(
        path: '/splashScreen',
        name: Routes.splashScreen.name,
        builder: (context, state) => SplashScreen(),
      ),

      GoRoute(
        path: '/loginScreen',
        name: Routes.loginScreen.name,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/bookAppointmentScreen',
        name: Routes.bookAppointmentScreen.name,
        builder: (context, state) => const BookAppointmentScreen(),
      ),
      GoRoute(
        path: '/systemSuggestingDoctorScreen',
        name: Routes.systemSuggestingDoctorScreen.name,
        builder: (context, state) => const SystemSuggestingDoctorScreen(),
      ),
      GoRoute(
        path: '/noAvailableDoctorScreen',
        name: Routes.noAvailableDoctorScreen.name,
        builder: (context, state) => const NoAvailableDoctorScreen(),
      ),
      GoRoute(
        path: '/suggestedDoctorScreen',
        name: Routes.suggestedDoctorScreen.name,
        builder: (context, state) => const SuggestedDoctorScreen(),
      ),
      GoRoute(
        path: '/selectAppointmentScreen',
        name: Routes.selectAppointmentScreen.name,
        builder: (context, state) => const SelectAppointmentScreen(),
      ),   GoRoute(
        path: '/appointmentSuccessScreen',
        name: Routes.appointmentSuccessScreen.name,
        builder: (context, state) => const AppointmentSuccessScreen(),
      ),


    ],
  );
}
