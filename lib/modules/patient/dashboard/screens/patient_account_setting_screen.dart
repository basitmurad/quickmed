import 'package:flutter/material.dart';
import 'package:quickmed/modules/patient/dashboard/widgets/custom_back_button.dart';
import 'package:quickmed/modules/patient/dashboard/widgets/heading_text.dart';
import 'package:quickmed/utils/app_text_style.dart';
import 'package:quickmed/utils/device_utility.dart';
import 'package:quickmed/utils/theme/colors/q_color.dart';
import 'package:quickmed/utils/widgets/TButton.dart';

class PatientAccountSettingScreen extends StatelessWidget {
  const PatientAccountSettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDark = TDeviceUtils.isDarkMode(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 10),
                CustomBackButton(),
                SizedBox(height: 30),
                Center(child: HeadingText(text: "Account Settings")),
                SizedBox(height: 30),
                QButton(
                  text: "Security",
                  buttonType: QButtonType.social,
                  onPressed: () {},
                ),
                SizedBox(height: 10),
                QButton(
                  text: "Personal Information",
                  buttonType: QButtonType.social,
                  onPressed: () {},
                ),
                SizedBox(height: 10),
                QButton(
                  text: "Address",
                  buttonType: QButtonType.social,
                  onPressed: () {},
                ),
                SizedBox(height: 10),
                QButton(
                  text: "Close Account",
                  buttonType: QButtonType.secondary,
                  onPressed: () {},
                ),
                SizedBox(height: 230),
                Text(
                  "QuickMed user since 6 feb 2025",
                  style: TAppTextStyle.inter(
                    color: isDark ? QColors.lightBackground : Colors.black,
                    fontSize: 20,
                    weight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
