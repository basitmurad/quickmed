import 'dart:math' show cos, sin, pi;

import 'package:flutter/material.dart';
import '../../../utils/app_text_style.dart';
import '../../../utils/device_utility.dart';
import '../../../utils/theme/colors/q_color.dart';
import '../../../utils/widgets/TButton.dart';

class SystemSuggestingDoctorScreen extends StatefulWidget {
  const SystemSuggestingDoctorScreen({super.key});

  @override
  State<SystemSuggestingDoctorScreen> createState() =>
      _SystemSuggestingDoctorScreenState();
}

class _SystemSuggestingDoctorScreenState
    extends State<SystemSuggestingDoctorScreen>
    with TickerProviderStateMixin {
  late AnimationController _dotsController;

  @override
  void initState() {
    super.initState();
    _dotsController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  void dispose() {
    _dotsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = TDeviceUtils.isDarkMode(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),

              /// Back button
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Row(
                  children: [
                    Icon(
                      Icons.arrow_back,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      "Go Back",
                      style: TAppTextStyle.inter(
                        color: isDark ? Colors.white : Colors.black,
                        fontSize: 16,
                        weight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 26),

              /// Main title
              Center(
                child: Text(
                  "Book Appointment",
                  style: TAppTextStyle.inter(
                    fontSize: 20,
                    weight: FontWeight.w600,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
              ),

              const SizedBox(height: 24),

              /// Subtitle
              Center(
                child: Text(
                  "System AI suggesting Doctor",
                  style: TAppTextStyle.inter(
                    fontSize: 15,
                    weight: FontWeight.w400,
                    color: isDark ? Colors.white70 : Colors.black87,
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AnimatedBuilder(
                        animation: _dotsController,
                        builder: (context, child) {
                          return SizedBox(
                            width: 70,
                            height: 70,
                            child: Stack(
                              alignment: Alignment.center,
                              children: List.generate(8, (index) {
                                final angle = index * pi / 4;
                                final offset = _dotsController.value * 2 * pi;
                                final currentAngle = angle + offset;

                                const radius = 24.0;

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
                                      color: QColors.newPrimary500
                                          .withOpacity(opacity * 0.8),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                );
                              }),
                            ),
                          );
                        },
                      ),

                      const SizedBox(height: 12),

                      Text(
                        "Loading...",
                        style: TAppTextStyle.inter(
                          fontSize: 16,
                          weight: FontWeight.w500,
                          color: isDark ? Colors.white70 : Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              /// Bottom button
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
