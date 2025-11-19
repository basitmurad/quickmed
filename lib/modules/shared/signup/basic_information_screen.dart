import 'package:flutter/material.dart';
import 'package:quickmed/utils/app_text_style.dart';
import 'package:quickmed/utils/widgets/TButton.dart';
import 'package:quickmed/utils/widgets/text_input_widget.dart';
import '../../../utils/device_utility.dart';
import '../../../utils/theme/colors/q_color.dart';

class BasicInformationScreen extends StatefulWidget {
  const BasicInformationScreen({super.key});

  @override
  State<BasicInformationScreen> createState() => _BasicInformationScreenState();
}

class _BasicInformationScreenState extends State<BasicInformationScreen> {
  @override
  Widget build(BuildContext context) {
    bool isDark = TDeviceUtils.isDarkMode(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [


              Center(
                child: Text(
                  "Basic Information",
                  style: TAppTextStyle.inter(
                    color: isDark ? Colors.white70 : Colors.black87,
                    fontSize: 16,
                    weight: FontWeight.w500,
                  ),
                ),
              ),

              const SizedBox(height: 28),

              /// ---------------- FIRST NAME ----------------
              TextInputWidget(
                dark: isDark,
                fillColor: Colors.transparent,
                headerText: "First Name",
              ),
              SizedBox(height: 12,),

              /// ---------------- LAST NAME ----------------
              TextInputWidget(
                dark: isDark,
                fillColor: Colors.transparent,
                headerText: "Last Name",
              ),
              SizedBox(height: 12,),

              /// ---------------- EMAIL ----------------
              TextInputWidget(
                dark: isDark,
                fillColor: Colors.transparent,
                headerText: "Email",
                isEmail: true,
              ),
              SizedBox(height: 12,),

              /// ---------------- PASSWORD ----------------
              TextInputWidget(
                dark: isDark,
                fillColor: Colors.transparent,
                headerText: "Password",
                isPassword: true,
                hintText: "Strong password",
              ),
              SizedBox(height: 12,),

              /// ---------------- CONFIRM PASSWORD ----------------
              TextInputWidget(
                dark: isDark,
                fillColor: Colors.transparent,
                headerText: "Confirm Password",
                isPassword: true,
              ),
              SizedBox(height: 12,),

              /// ---------------- DATE OF BIRTH ----------------
              TextInputWidget(
                dark: isDark,
                fillColor: Colors.transparent,
                headerText: "Date of Birth",
              ),
              SizedBox(height: 12,),

              /// ---------------- GENDER ----------------
              TextInputWidget(
                dark: isDark,
                fillColor: Colors.transparent,
                headerText: "Gender",
              ),

              const SizedBox(height: 22),

            ],
          ),
        ),
      ),
    );
  }
}
