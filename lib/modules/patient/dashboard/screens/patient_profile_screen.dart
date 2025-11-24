import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quickmed/modules/patient/dashboard/widgets/custom_back_button.dart';
import 'package:quickmed/modules/patient/dashboard/widgets/heading_text.dart';
import 'package:quickmed/modules/patient/dashboard/widgets/profile_pic.dart';
import 'package:quickmed/utils/app_text_style.dart';
import 'package:quickmed/utils/device_utility.dart';
import 'package:quickmed/utils/image_path.dart';
import 'package:quickmed/utils/theme/colors/q_color.dart';
import 'package:quickmed/utils/widgets/TButton.dart';

class PatientProfileScreen extends StatelessWidget {
  const PatientProfileScreen({super.key});

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
                SizedBox(height: 20),
                Center(
                  child: ProfilePic(
                    imagePath: QImagesPath.profileImg,
                    onTap: () {},
                  ),
                ),
                SizedBox(height: 10),

                /// ---------------- WELCOME HEADING ---------------- ///
                HeadingText(
                  text: "Welcome John Doe",
                  textColor: QColors.newPrimary500,
                ),

                /// ---------------- WELCOME HEADING ---------------- ///

                /// ---------------- SETTING BUTTONS ---------------- ///
                QButton(
                  text: "Medical History",
                  buttonType: QButtonType.social,
                  onPressed: () {},
                ),
                SizedBox(height: 10),
                QButton(
                  text: "Rate Appointment",
                  buttonType: QButtonType.social,
                  onPressed: () => context.push('/patientAppointmentScreen'),
                ),
                SizedBox(height: 10),
                QButton(
                  text: "My Bio",
                  buttonType: QButtonType.social,
                  onPressed: () {},
                ),
                SizedBox(height: 10),
                QButton(
                  text: "Privacy",
                  buttonType: QButtonType.social,
                  onPressed: () {},
                ),
                SizedBox(height: 10),
                QButton(
                  text: "Follow",
                  buttonType: QButtonType.social,
                  onPressed: () {},
                ),
                SizedBox(height: 10),
                QButton(
                  text: "Chat Doctor",
                  buttonType: QButtonType.social,
                  onPressed: () =>
                      context.push('/chatDoctorSelectAppointmentScreen'),
                ),
                SizedBox(height: 10),
                QButton(
                  text: "Account Settings",
                  buttonType: QButtonType.social,
                  onPressed: () => context.push('/patientAccountSettingScreen'),
                ),
                SizedBox(height: 10),
                QButton(
                  text: "Log Out",
                  buttonType: QButtonType.secondary,
                  onPressed: () {},
                ),

                /// ---------------- SETTING BUTTONS ---------------- ///
                SizedBox(height: 110),
                Center(
                  child: Text(
                    "1.0 QuickMed",
                    style: TAppTextStyle.inter(
                      color: isDark ? QColors.lightBackground : Colors.black,
                      fontSize: 20,
                      weight: FontWeight.w400,
                    ),
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
