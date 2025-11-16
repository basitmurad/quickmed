import 'dart:math' show cos, sin, pi;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quickmed/utils/app_text_style.dart';
import 'package:quickmed/utils/device_utility.dart';
import 'package:quickmed/utils/image_path.dart';
import '../../../utils/theme/colors/q_color.dart';

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
            FadeTransition(
              opacity: _fadeAnimation,
              child: Column(
                children: [
                  _buildCrossLogo(),
                  const SizedBox(height: 12),
                  Text(
                    'QuickMed',
                    style: TAppTextStyle.inter(
                      color: isDark ? Colors.white : QColors.primary,
                      fontSize: 56.0,
                      letterSpacing: 1.9,
                      height: 1.2,
                      weight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
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

  Widget _buildCrossLogo() {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Stack(
        children: [
          Positioned(
            left: 45,
            top: 10,
            child: Container(
              width: 30,
              height: 100,
              decoration: BoxDecoration(
                color: QColors.primary,
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
          Positioned(
            left: 10,
            top: 45,
            child: Container(
              width: 100,
              height: 30,
              decoration: BoxDecoration(
                color: QColors.primary,
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
          Positioned(
            right: 8,
            top: 8,
            child: Container(
              width: 20,
              height: 20,
              decoration: const BoxDecoration(
                color: QColors.primary,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}