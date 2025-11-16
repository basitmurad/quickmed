import 'dart:math' show cos, sin, pi;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:quickmed/utils/app_text_style.dart';
import 'package:quickmed/utils/device_utility.dart';
import 'package:quickmed/utils/image_path.dart';
import '../../../utils/theme/colors/q_color.dart';
import '../../../utils/widgets/quick_med_logo.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
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

    // Navigate to LoginScreen after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        context.go('/loginScreen'); // GoRouter navigation
      }
    });
  }


  @override
  void dispose() {
    _fadeController.dispose();
    _dotsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = TDeviceUtils.isDarkMode(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(flex: 1),

            // LOGO + APP NAME
            QuickMedLogo(
              fadeAnimation: _fadeAnimation,
              isDark: isDark,
            ),


            const SizedBox(height: 25),

            FadeTransition(
              opacity: _fadeAnimation,
              child: Text(
                'Book instant Medical Appointment',
                style: TAppTextStyle.inter(
                  color: isDark ? Colors.white70 : Colors.grey.shade800,
                  fontSize: 14.0,
                  weight: FontWeight.w400,
                ),
              ),
            ),

            const Spacer(flex: 2),

            // CIRCULAR DOT LOADER
            AnimatedBuilder(
              animation: _dotsController,
              builder: (context, child) {
                return SizedBox(
                  width: 70,
                  height: 70,
                  child: Stack(
                    alignment: Alignment.center,
                    children: List.generate(8, (index) {
                      final angle = index * pi / 4; // 45° increments
                      final offset = _dotsController.value * 2 * pi;
                      final currentAngle = angle + offset;

                      final radius = 24.0;

                      final dx = radius * cos(currentAngle);
                      final dy = radius * sin(currentAngle);

                      final opacity = (1 + cos(currentAngle)) / 2;

                      return Positioned(
                        left: 35 + dx,
                        top: 35 + dy,
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: QColors.newPrimary500.withOpacity(
                              opacity * 0.8,
                            ),
                            shape: BoxShape.circle,
                          ),
                        ),
                      );
                    }),
                  ),
                );
              },
            ),

            const SizedBox(height: 10),

            FadeTransition(
              opacity: _fadeAnimation,
              child: Text(
                'Loading...',
                style: TAppTextStyle.inter(
                  color: isDark ? Colors.white : QColors.darkGray900,
                  fontSize: 16.0,
                  weight: FontWeight.w500,
                ),
              ),
            ),

            const Spacer(flex: 2),

            // IMAGES AT BOTTOM
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    height: 86,
                    width: 86,
                    fit: BoxFit.cover,
                    image: AssetImage(QImagesPath.image1),
                  ),
                  const SizedBox(width: 12),
                  Image(
                    height: 86,
                    width: 86,
                    fit: BoxFit.cover,
                    image: AssetImage(QImagesPath.image2),
                  ),
                  const SizedBox(width: 12),
                  Image(
                    height: 86,
                    width: 86,
                    fit: BoxFit.cover,
                    image: AssetImage(QImagesPath.image3),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

}