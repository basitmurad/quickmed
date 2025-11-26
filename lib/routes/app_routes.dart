import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quickmed/routes/routes.dart';

import '../core/global.dart';
import '../modules/doctor/acceptappointment/accept_appointment.dart';
import '../modules/doctor/appointmentaccepted/appointment_accepted_screen.dart';
import '../modules/doctor/dashboard/dash_board_screen.dart';
import '../modules/doctor/doctorappointment/doctor_appointment_screen.dart';
import '../modules/doctor/doctorappointmentdetail/doctor_appointment_screen.dart';
import '../modules/doctor/doctormap/get_direction_screen.dart';
import '../modules/doctor/doctorprofile/doctor_account_setting.dart';
import '../modules/doctor/doctorprofile/doctor_profile_screen.dart';
import '../modules/doctor/rejectappointment/appointment_rejected_screen.dart';
import '../modules/doctor/rejectappointment/reject_appointment_screen.dart';
import '../modules/doctor/updateavailabilitycal/availability_updated_screen.dart';
import '../modules/doctor/updateavailabilitycal/update_availability_screen.dart';
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
    initialLocation: '/splashScreen',
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
        path: '/dashBoardScreen',
        name: Routes.dashBoardScreen.name,
        builder: (context, state) => const DashBoardScreen(),
      ),
      GoRoute(
        path: '/doctorProfileScreen',
        name: Routes.doctorProfileScreen.name,
        builder: (context, state) => const DoctorProfileScreen(),
      ),
      GoRoute(
        path: '/doctorAccountSetting',
        name: Routes.doctorAccountSetting.name,
        builder: (context, state) => const DoctorAccountSetting(),
      ),
      GoRoute(
        path: '/doctorAppointments',
        name: Routes.doctorAppointments.name,
        builder: (context, state) => const DoctorAppointments(),
      ),
      GoRoute(
        path: '/DoctorAppointmentScreen',
        name: Routes.DoctorAppointmentScreen.name,
        builder: (context, state) => const DoctorAppointmentScreen(),
      ),
      GoRoute(
        path: '/acceptAppointment',
        name: Routes.acceptAppointment.name,
        builder: (context, state) => const AcceptAppointment(),
      ),
      GoRoute(
        path: '/appointmentAcceptedScreen',
        name: Routes.appointmentAcceptedScreen.name,
        builder: (context, state) => const AppointmentAcceptedScreen(),
      ),
      GoRoute(
        path: '/rejectAppointment',
        name: Routes.rejectAppointmentScreen.name,
        builder: (context, state) => const RejectAppointmentScreen(),
      ),
      GoRoute(
        path: '/updateAvailabilityScreen',
        name: Routes.updateAvailabilityScreen.name,
        builder: (context, state) => const UpdateAvailabilityScreen(),
      ),
      GoRoute(
        path: '/availabilityUpdatedScreen',
        name: Routes.availabilityUpdatedScreen.name,
        builder: (context, state) => const AvailabilityUpdatedScreen(),
      ),
      GoRoute(
        path: '/appointmentRejectedScreen',
        name: Routes.appointmentRejectedScreen.name,
        builder: (context, state) => const AppointmentRejectedScreen(),
      ),
      GoRoute(
        path: '/getDirectionScreen',
        name: Routes.getDirectionScreen.name,
        builder: (context, state) => const GetDirectionScreen(),
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
