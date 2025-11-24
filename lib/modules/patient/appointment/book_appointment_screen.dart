import 'package:flutter/material.dart';
import '../../../utils/app_text_style.dart';
import '../../../utils/device_utility.dart';
import '../../../utils/widgets/TButton.dart';
import '../../../utils/widgets/text_input_widget.dart';

class BookAppointmentScreen extends StatefulWidget {
  const BookAppointmentScreen({super.key});

  @override
  State<BookAppointmentScreen> createState() => _BookAppointmentScreenState();
}

class _BookAppointmentScreenState extends State<BookAppointmentScreen> {
  final TextEditingController historyController = TextEditingController();
  final TextEditingController symptomsController = TextEditingController();

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
              /// Back button
              SizedBox(height: 12),
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

              /// Title
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

              const SizedBox(height: 30),

              /// --- Medical History ---
              TextInputWidget(
                controller: historyController,
                headerText: "Enter Your Medical History (optional)",
                hintText: "e.g. Hypertension",
                dark: isDark,
                fillColor: Colors.transparent,
              ),

              const SizedBox(height: 30),

              /// --- Symptoms ---
              TextInputWidget(
                controller: symptomsController,
                headerText: "Enter Current Symptoms",
                hintText: "e.g. Cough, Chest pain, Head ache etc",
                dark: isDark,
                fillColor: Colors.transparent,
              ),

              Spacer(),

              /// Continue button
              QButton(
                text: "Continue",
                onPressed: () {
                  // You can add validation or submit here
                },
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
