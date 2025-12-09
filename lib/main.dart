import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:quickmed/modules/provider/LoginProvider.dart';
import 'package:quickmed/modules/provider/SignUpProvider.dart';
import 'package:quickmed/routes/app_routes.dart';
import 'package:quickmed/utils/theme/themes.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Set system UI overlay style
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SignUpProvider()),
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        // Add more providers here
      ],

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
