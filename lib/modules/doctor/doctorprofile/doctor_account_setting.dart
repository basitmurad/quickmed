import 'package:flutter/material.dart';
import '../../../routes/app_routes.dart';
import '../../../utils/app_text_style.dart';
import '../../../utils/device_utility.dart';
import '../../../utils/theme/colors/q_color.dart';
import '../widgets/summary_item.dart';

class DoctorAccountSetting extends StatelessWidget {
  const DoctorAccountSetting({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDark = TDeviceUtils.isDarkMode(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: Column(
              children: [
                /// BACK BUTTON
                Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
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
                            color: isDark ? Colors.white : QColors.lightGray800,
                            fontSize: 16,
                            weight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),



                const SizedBox(height: 20),

                /// Add your remaining page widgets here...
                Text(
                  "Account Settings",
                  style: TAppTextStyle.inter(
                    fontSize: 19,
                    weight: FontWeight.w700,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
                SizedBox(height: 16),
                SummaryItem(title: 'Security', ),
                SummaryItem(title: 'Personal Information', ),
                SummaryItem(title: 'Address',onTap: (){
                  AppRouter.router.push('/doctorAppointmentScreen');
                }, ),
                SummaryItem(title: 'Close Account',onTap: (){
                  AppRouter.router.push('/doctorAppointments');
                }, ),
                SizedBox(height: 20,),
                Text(
                  "QuickMed user since 6 feb 2025",
                  style: TAppTextStyle.inter(
                    color:  isDark ? Colors.white70 : Colors.black87,
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
