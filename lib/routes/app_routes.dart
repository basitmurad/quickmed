

import 'package:go_router/go_router.dart';
import 'package:quickmed/routes/routes.dart';

import '../core/global.dart';
import '../modules/shared/login/login_screen.dart';
import '../modules/shared/splash/splash_screen.dart';

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


    ],
  );
}
