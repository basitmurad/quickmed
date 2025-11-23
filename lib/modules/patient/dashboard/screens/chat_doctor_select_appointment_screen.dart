import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quickmed/modules/patient/dashboard/widgets/appointment_widget.dart';
import 'package:quickmed/modules/patient/dashboard/widgets/custom_back_button.dart';
import 'package:quickmed/modules/patient/dashboard/widgets/heading_text.dart';
import 'package:quickmed/utils/app_text_style.dart';
import 'package:quickmed/utils/device_utility.dart';
import 'package:quickmed/utils/image_path.dart';
import 'package:quickmed/utils/theme/colors/q_color.dart';
import 'package:quickmed/utils/widgets/TButton.dart';
import 'package:quickmed/utils/widgets/text_input_widget.dart';

class ChatDoctorSelectAppointmentScreen extends StatelessWidget {
  const ChatDoctorSelectAppointmentScreen({super.key});

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
                TextInputWidget(
                  dark: isDark,
                  hintText: "Search Appointments",
                  fillColor: Colors.transparent,
                  radius: BorderRadius.circular(24),
                  suffixSvgPath: QImagesPath.search,
                  controller: TextEditingController(),
                ),
                SizedBox(height: 20),
                Center(child: HeadingText(text: "Chat Doctor")),
                SizedBox(height: 20),
                Center(
                  child: Text(
                    "Select Appointment",
                    style: TAppTextStyle.inter(
                      color: isDark ? QColors.lightBackground : Colors.black,
                      fontSize: 20,
                      weight: FontWeight.w400,
                    ),
                  ),
                ),
                SizedBox(height: 30),
                AppointmentWidget(
                  date: "10 October 2025",
                  time: "10:30 AM",
                  status: Status.accepted,
                  onTap: () => context.push('/chatDoctorScreen'),
                ),
                AppointmentWidget(
                  date: "9 October 2025",
                  time: "9:30 AM",
                  status: Status.rejected,
                ),
                AppointmentWidget(
                  date: "1 October 2025",
                  time: "10:30 AM",
                  status: Status.complete,
                ),
                AppointmentWidget(
                  date: "2 October 2025",
                  time: "10:30 AM",
                  status: Status.noShow,
                ),
                QButton(
                  text: "View All",
                  buttonType: QButtonType.text,
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
    ;
  }
}
