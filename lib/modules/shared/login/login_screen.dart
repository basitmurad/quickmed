import 'package:flutter/material.dart';
import 'package:quickmed/routes/app_routes.dart';
import 'package:quickmed/utils/app_text_style.dart';
import 'package:quickmed/utils/widgets/TButton.dart';
import 'package:quickmed/utils/widgets/text_input_widget.dart';

import '../../../utils/device_utility.dart';
import '../../../utils/theme/colors/q_color.dart';
import '../../../utils/widgets/quick_med_logo.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _dotsController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _fadeController, curve: Curves.easeIn));

    _dotsController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();

    _fadeController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = TDeviceUtils.isDarkMode(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 46),

              /// ---------------- LOGO ----------------
              Padding(
                padding: const EdgeInsets.all(28.0),
                child: QuickMedLogo(
                  fadeAnimation: _fadeAnimation,
                  isDark: isDark,
                  logoSize: 100,
                  textSize: 54,
                ),
              ),

              /// ---------------- EMAIL ----------------
              TextInputWidget(
                dark: isDark,
                fillColor: Colors.transparent,
                headerText: "Email",
                isEmail: true,
              ),
              const SizedBox(height: 16),

              /// ---------------- PASSWORD ----------------
              TextInputWidget(
                dark: isDark,
                fillColor: Colors.transparent,
                headerText: "Password",
                isPassword: true,
              ),

              /// Forgot Password (Right aligned)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6.0),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      AppRouter.router.push('/forgotPasswordScreen');


                      // TODO: Navigate to forgot password screen
                    },
                    child: Text(
                      "Forgot Password?",
                      style: TAppTextStyle.inter(
                        color: isDark ? QColors.primary : QColors.primary,
                        fontSize: 14,
                        height: 1.4,
                        weight: FontWeight.w500,
                        shouldUnderline: true,
                        underlineColor: QColors.primary,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              /// ---------------- LOGIN BUTTON ----------------
              QButton(text: 'Login', onPressed: () {
                AppRouter.router.push('/patientBottomNavScreen');


              }),

              const SizedBox(height: 24),

              /// ---------------- NO ACCOUNT TEXT ----------------
              Text(
                "Don’t have an account?",
                style: TAppTextStyle.inter(
                  color: isDark ? Colors.white : QColors.lightGray800,
                  fontSize: 16.0,
                  height: 1.2,
                  weight: FontWeight.w500,
                ),
              ),

              /// Create Account (underlined)
              GestureDetector(
                onTap: () {
                  AppRouter.router.push('/signUpScreen');
                  // TODO: Navigate to create account screen
                },
                child: Text(
                  "Create an Account",
                  style: TAppTextStyle.inter(
                    color: QColors.primary,
                    fontSize: 16.0,
                    height: 1.8,
                    weight: FontWeight.w500,
                    shouldUnderline: true,
                    underlineColor: QColors.primary,
                  ),
                ),
              ),

              const SizedBox(height: 24),

              /// ---------------- NEED HELP BUTTON ----------------
              GestureDetector(
                onTap: () {
                  // TODO: Navigate to support/help page
                },
                child: Text(
                  "Need Help?",
                  style: TAppTextStyle.inter(
                    color: isDark ? Colors.white : QColors.lightGray800,
                    fontSize: 15.0,
                    height: 1.8,
                    weight: FontWeight.w500,
                    shouldUnderline: true,
                    underlineColor: isDark
                        ? Colors.white
                        : QColors.lightGray800,
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
