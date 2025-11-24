import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quickmed/modules/patient/dashboard/screens/chat_doctor_screen.dart';
import 'package:quickmed/modules/patient/dashboard/screens/chat_doctor_select_appointment_screen.dart';
import 'package:quickmed/modules/patient/dashboard/screens/patient_account_setting_screen.dart';
import 'package:quickmed/modules/patient/dashboard/screens/patient_appointment_screen.dart';
import 'package:quickmed/modules/patient/dashboard/screens/patient_dashboard_screen.dart';
import 'package:quickmed/modules/patient/dashboard/screens/patient_profile_screen.dart';
import 'package:quickmed/modules/patient/appointment/book_appointment_screen.dart' hide SystemSuggestingDoctorScreen;
import 'package:quickmed/routes/routes.dart';
import '../core/global.dart';
import '../modules/patient/appointment/appointment_success_screen.dart';
import '../modules/patient/appointment/no_available_doctor_screen.dart';
import '../modules/patient/appointment/select_appointment_screen.dart';
import '../modules/patient/appointment/suggested_doctor_screen.dart';
import '../modules/patient/appointment/system_suggesting_doctor_screen.dart';
import '../modules/shared/error/general_error_screen.dart';
import '../modules/shared/login/login_screen.dart';
import '../modules/shared/otp/otp_verification_screen.dart';
import '../modules/shared/signup/signup_screen.dart';
import '../modules/shared/splash/splash_screen.dart';
import '../modules/shared/success_screen/account_creation_success_screen.dart';

class AppRouter {
  static final router = GoRouter(
    navigatorKey: navigatorKey,
    debugLogDiagnostics: true,
    initialLocation: //'/splashScreen',
        '/patientDashboardScreen',
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
      GoRoute(
        path: '/signUpScreen',
        name: Routes.signUpScreen.name,
        builder: (context, state) => const SignUpScreen(),
      ),
      GoRoute(
        path: '/oTPVerificationScreen',
        name: Routes.oTPVerificationScreen.name,
        builder: (context, state) => const OTPVerificationScreen(),
      ),
      GoRoute(
        path: '/accountCreationSuccessScreen',
        name: Routes.accountCreationSuccessScreen.name,
        builder: (context, state) => const AccountCreationSuccessScreen(),
      ),
      GoRoute(
        path: '/patientDashboardScreen',
        name: Routes.patientDashboardScreen.name,
        builder: (context, state) => const PatientDashboardScreen(),
      ),
      GoRoute(
        path: '/patientProfileScreen',
        name: Routes.patientProfileScreen.name,
        builder: (context, state) => const PatientProfileScreen(),
      ),
      GoRoute(
        path: '/patientAccountSettingScreen',
        name: Routes.patientAccountSettingScreen.name,
        builder: (context, state) => const PatientAccountSettingScreen(),
      ),
      GoRoute(
        path: '/patientAppointmentScreen',
        name: Routes.patientAppointmentScreen.name,
        builder: (context, state) => const PatientAppointmentScreen(),
      ),
      GoRoute(
        path: '/chatDoctorScreen',
        name: Routes.chatDoctorScreen.name,
        builder: (context, state) => const ChatDoctorScreen(),
      ),
      GoRoute(
        path: '/chatDoctorSelectAppointmentScreen',
        name: Routes.chatDoctorSelectAppointmentScreen.name,
        builder: (context, state) => const ChatDoctorSelectAppointmentScreen(),
      ),
      GoRoute(
        path: '/generalErrorScreen',
        name: Routes.generalErrorScreen.name,
        builder: (context, state) {
          final data = state.extra as Map<String, dynamic>?;

          return GeneralErrorScreen(
            title: data?['title'] ?? "Error",
            message: data?['message'] ?? "Something went wrong.",
            icon: data?['icon'] ?? Icons.error_outline,
            buttonText: data?['buttonText'] ?? "Retry",
            onRetry: data?['onRetry'] ?? () {},
          );
        },
      ),


    ],
  );
}
