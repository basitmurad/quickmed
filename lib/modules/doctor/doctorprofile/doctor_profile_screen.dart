import 'package:flutter/material.dart';
import 'package:quickmed/utils/theme/colors/q_color.dart';

import '../../../routes/app_routes.dart';
import '../../../utils/app_text_style.dart';
import '../../../utils/device_utility.dart';
import '../../../utils/image_path.dart';
import '../../../utils/sizes.dart';
import '../widgets/summary_item.dart';

class DoctorProfileScreen extends StatefulWidget {
  const DoctorProfileScreen({super.key});

  @override
  State<DoctorProfileScreen> createState() => _DoctorProfileScreenState();
}
class _DoctorProfileScreenState extends State<DoctorProfileScreen> {
  @override
  Widget build(BuildContext context) {
    bool isDark = TDeviceUtils.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close, size: 28),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: QSizes.md, vertical: QSizes.md),
            child: Column(
              children: [
                SizedBox(height: QSizes.fontSizeXESm),
                Align(
                  alignment: Alignment.center,
                  child: CircleAvatar(
                    radius: 35,
                    backgroundImage: AssetImage(QImagesPath.profile),
                  ),
                ),
                SizedBox(height: 15),
                Text(
                  'Welcome Sara John',
                  style: TAppTextStyle.inter(
                    color: QColors.newPrimary700,
                    fontSize: 20,
                    weight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 25),
                SummaryItem(title: 'Specialization', ),
                SummaryItem(title: 'Experience', ),
                SummaryItem(title: 'Location',  ),
                SummaryItem(title: 'My Bio', ),
                SummaryItem(title: 'My Rating', ),
                SummaryItem(title: 'Privacy', ),
                SummaryItem(title: 'Follow', ),
                SummaryItem(title: 'Chat Patient', ),
                SummaryItem(title: 'Account Settings',onTap: (){
                  AppRouter.router.push('/doctorAccountSetting');
                }, ),
                SummaryItem(title: 'log Out',textColor1: Colors.red, ),
                SizedBox(height: 25),
                Text(
                  "1.0 QuickMed",
                  style: TAppTextStyle.inter(
                    color:  isDark ? Colors.white70 : Colors.black87,
                    fontSize: 18,
                    weight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
