import 'package:flutter/material.dart';
import '../../../utils/app_text_style.dart';
import '../../../utils/device_utility.dart';
import '../../../utils/widgets/TButton.dart';

class AppointmentSuccessScreen extends StatefulWidget {
  const AppointmentSuccessScreen({super.key});

  @override
  State<AppointmentSuccessScreen> createState() => _AppointmentSuccessScreenState();
}

class _AppointmentSuccessScreenState extends State<AppointmentSuccessScreen> {

  @override
  Widget build(BuildContext context) {
    final bool isDark = TDeviceUtils.isDarkMode(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            children: [
              const SizedBox(height: 20),

              /// Main White Card Container
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 45, horizontal: 20),
                decoration: BoxDecoration(

                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [

                    /// Success Icon
                    const Icon(
                      Icons.check_box,
                      color: Colors.lightGreen,
                      size: 70,
                    ),

                    const SizedBox(height: 18),

                    /// Success Message
                    Text(
                      "Appointment Booked Successfully",
                      style: TAppTextStyle.inter(
                        fontSize: 18,
                        weight: FontWeight.w600,
                        color: Colors.green,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 28),

                    /// Doctor Name
                    Text(
                      "Dr Sarah Johnson",
                      style: TAppTextStyle.inter(
                        fontSize: 16,
                        weight: FontWeight.w600,
                        color: Colors.blue,
                      ),
                    ),

                    const SizedBox(height: 10),

                    /// Date & Time
                    Text(
                      "Wednesday 25th August 14:30 PM",
                      style: TAppTextStyle.inter(
                        fontSize: 14,
                        weight: FontWeight.w400,
                        color: isDark ? Colors.white70 : Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),

              const Spacer(),

              /// Done Button
              QButton(
                text: "Done",
                onPressed: () => Navigator.pop(context),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
