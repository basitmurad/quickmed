// import 'package:flutter/material.dart';
// import '../../../utils/app_text_style.dart';
// import '../../../utils/device_utility.dart';
// import '../../../utils/widgets/TButton.dart';
//
// class AppointmentSuccessScreen extends StatefulWidget {
//   const AppointmentSuccessScreen({super.key});
//
//   @override
//   State<AppointmentSuccessScreen> createState() => _AppointmentSuccessScreenState();
// }
//
// class _AppointmentSuccessScreenState extends State<AppointmentSuccessScreen> {
//
//   @override
//   Widget build(BuildContext context) {
//     final bool isDark = TDeviceUtils.isDarkMode(context);
//
//     return Scaffold(
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 18),
//           child: Column(
//             children: [
//               const SizedBox(height: 20),
//
//               /// Main White Card Container
//               Container(
//                 width: double.infinity,
//                 padding: const EdgeInsets.symmetric(vertical: 45, horizontal: 20),
//                 decoration: BoxDecoration(
//
//                 ),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//
//                     /// Success Icon
//                     const Icon(
//                       Icons.check_box,
//                       color: Colors.lightGreen,
//                       size: 70,
//                     ),
//
//                     const SizedBox(height: 18),
//
//                     /// Success Message
//                     Text(
//                       "Appointment Booked Successfully",
//                       style: TAppTextStyle.inter(
//                         fontSize: 18,
//                         weight: FontWeight.w600,
//                         color: Colors.green,
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//
//                     const SizedBox(height: 28),
//
//                     /// Doctor Name
//                     Text(
//                       "Dr Sarah Johnson",
//                       style: TAppTextStyle.inter(
//                         fontSize: 16,
//                         weight: FontWeight.w600,
//                         color: Colors.blue,
//                       ),
//                     ),
//
//                     const SizedBox(height: 10),
//
//                     /// Date & Time
//                     Text(
//                       "Wednesday 25th August 14:30 PM",
//                       style: TAppTextStyle.inter(
//                         fontSize: 14,
//                         weight: FontWeight.w400,
//                         color: isDark ? Colors.white70 : Colors.black87,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//
//               const Spacer(),
//
//               /// Done Button
//               QButton(
//                 text: "Done",
//                 onPressed: () => Navigator.pop(context),
//               ),
//
//               const SizedBox(height: 20),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../utils/app_text_style.dart';
import '../../../utils/device_utility.dart';
import '../../../utils/widgets/TButton.dart';
import '../../../utils/theme/colors/q_color.dart';

class AppointmentSuccessScreen extends StatefulWidget {
  final Map<String, dynamic>? bookingData;

  const AppointmentSuccessScreen({
    super.key,
    this.bookingData,
  });

  @override
  State<AppointmentSuccessScreen> createState() =>
      _AppointmentSuccessScreenState();
}

class _AppointmentSuccessScreenState extends State<AppointmentSuccessScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize animation controller
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    // Scale animation for the success icon
    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.elasticOut,
      ),
    );

    // Fade animation for the content
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.3, 1.0, curve: Curves.easeIn),
      ),
    );

    // Start animation
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // Get booking data or use defaults
  String get doctorName =>
      widget.bookingData?['doctorName'] ?? 'Dr Sarah Johnson';
  String get specialization =>
      widget.bookingData?['specialization'] ?? 'Cardiologist';
  String get dateTime =>
      widget.bookingData?['dateTime'] ?? 'Wednesday 25th August 14:30 PM';
  String get hospital =>
      widget.bookingData?['hospital'] ?? 'City General Hospital';
  String get consultationFee => widget.bookingData?['consultationFee'] ?? '\$80';

  @override
  Widget build(BuildContext context) {
    final bool isDark = TDeviceUtils.isDarkMode(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            children: [
              const SizedBox(height: 40),

              /// Main Success Card Container
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    child: AnimatedBuilder(
                      animation: _animationController,
                      builder: (context, child) {
                        return Opacity(
                          opacity: _fadeAnimation.value,
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                                vertical: 45, horizontal: 20),
                            decoration: BoxDecoration(
                              color: isDark ? Colors.grey[850] : Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 20,
                                  offset: const Offset(0, 10),
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                /// Animated Success Icon
                                Transform.scale(
                                  scale: _scaleAnimation.value,
                                  child: Container(
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: Colors.green.withOpacity(0.1),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.check_circle,
                                      color: Colors.green,
                                      size: 80,
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 24),

                                /// Success Message
                                Text(
                                  "Appointment Booked Successfully",
                                  style: TAppTextStyle.inter(
                                    fontSize: 20,
                                    weight: FontWeight.w700,
                                    color: Colors.green,
                                  ),
                                  textAlign: TextAlign.center,
                                ),

                                const SizedBox(height: 12),

                                Text(
                                  "Your appointment has been confirmed",
                                  style: TAppTextStyle.inter(
                                    fontSize: 14,
                                    weight: FontWeight.w400,
                                    color: isDark
                                        ? Colors.white70
                                        : Colors.black54,
                                  ),
                                  textAlign: TextAlign.center,
                                ),

                                const SizedBox(height: 36),

                                /// Divider
                                Divider(
                                  color: isDark
                                      ? Colors.grey[700]
                                      : Colors.grey[300],
                                  thickness: 1,
                                ),

                                const SizedBox(height: 24),

                                /// Doctor Details Section
                                _buildDetailRow(
                                  context,
                                  icon: Icons.person,
                                  label: "Doctor",
                                  value: doctorName,
                                  isDark: isDark,
                                ),

                                const SizedBox(height: 16),

                                _buildDetailRow(
                                  context,
                                  icon: Icons.medical_services,
                                  label: "Specialization",
                                  value: specialization,
                                  isDark: isDark,
                                ),

                                const SizedBox(height: 16),

                                _buildDetailRow(
                                  context,
                                  icon: Icons.calendar_today,
                                  label: "Date & Time",
                                  value: dateTime,
                                  isDark: isDark,
                                ),

                                const SizedBox(height: 16),

                                _buildDetailRow(
                                  context,
                                  icon: Icons.local_hospital,
                                  label: "Hospital",
                                  value: hospital,
                                  isDark: isDark,
                                ),

                                const SizedBox(height: 16),

                                _buildDetailRow(
                                  context,
                                  icon: Icons.payment,
                                  label: "Consultation Fee",
                                  value: consultationFee,
                                  isDark: isDark,
                                ),

                                const SizedBox(height: 24),

                                /// Divider
                                Divider(
                                  color: isDark
                                      ? Colors.grey[700]
                                      : Colors.grey[300],
                                  thickness: 1,
                                ),

                                const SizedBox(height: 20),

                                /// Info Message
                                Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: QColors.newPrimary500.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.info_outline,
                                        color: QColors.newPrimary500,
                                        size: 20,
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Text(
                                          "You'll receive a confirmation email shortly",
                                          style: TAppTextStyle.inter(
                                            fontSize: 12,
                                            weight: FontWeight.w500,
                                            color: isDark
                                                ? Colors.white70
                                                : Colors.black87,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              /// Action Buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        // View appointment details
                        print("View Details");
                      },
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        side: BorderSide(color: QColors.newPrimary500),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        "View Details",
                        style: TAppTextStyle.inter(
                          fontSize: 16,
                          weight: FontWeight.w600,
                          color: QColors.newPrimary500,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: QButton(
                      text: "Done",
                      onPressed: () {
                        // Navigate back to home/dashboard
                        context.go('/patientBottomNavScreen');
                      },
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(
      BuildContext context, {
        required IconData icon,
        required String label,
        required String value,
        required bool isDark,
      }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: QColors.newPrimary500.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            size: 20,
            color: QColors.newPrimary500,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TAppTextStyle.inter(
                  fontSize: 12,
                  weight: FontWeight.w400,
                  color: isDark ? Colors.white60 : Colors.black54,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: TAppTextStyle.inter(
                  fontSize: 14,
                  weight: FontWeight.w600,
                  color: isDark ? Colors.white : Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}