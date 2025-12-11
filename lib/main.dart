import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:quickmed/core/endpoint/api_endpoints.dart';
import 'package:quickmed/core/network/api_client.dart';
import 'package:quickmed/modules/provider/LoginProvider.dart';
import 'package:quickmed/modules/provider/SignUpProvider.dart';
import 'package:quickmed/routes/app_routes.dart';
import 'package:quickmed/utils/theme/themes.dart';

import 'app_provider.dart';
import 'core/di/InjectionContainer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Set system UI overlay style
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  final di = InjectionContainer();
  await di.init(baseUrl: ApiEndpoints.baseUrl);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AppProviders.wrapWithProviders(
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Your App Name',

        // Apply custom themes
        theme: TAppTheme.lightTheme,
        darkTheme: TAppTheme.darkTheme,
        themeMode: ThemeMode.system,

        // Connect GoRouter
        routerConfig: AppRouter.router,
      ),
    );
  }
}
