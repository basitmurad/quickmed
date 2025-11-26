import 'package:flutter/material.dart';

import '../../../routes/app_routes.dart';
import '../../../utils/app_text_style.dart';
import '../../../utils/device_utility.dart';
import '../../../utils/image_path.dart';
import '../../../utils/sizes.dart';
import '../../../utils/theme/colors/q_color.dart';
import '../widgets/appointment_card_widget.dart';
class DoctorAppointments extends StatefulWidget {
  const DoctorAppointments({super.key});

  @override
  State<DoctorAppointments> createState() => _DoctorAppointmentsState();
}

class _DoctorAppointmentsState extends State<DoctorAppointments> {
  @override
  Widget build(BuildContext context) {
    bool isDark = TDeviceUtils.isDarkMode(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: Column(
                children: [
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
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      InkWell(
                        onTap: () {
                          AppRouter.router.push('/doctorProfileScreen');
                        },
                        child: CircleAvatar(
                          radius: 20,
                          backgroundImage: AssetImage(QImagesPath.profile),
                        ),
                      ),
                      SizedBox(width: 2),
                      Row(
                        children: [
                          SizedBox(
                            height: 38,
                            width: 230,
                            child: Center(
                              child: TextField(
                                cursorColor: Colors.black,

                                decoration: InputDecoration(
                                  hintText: "Search Appointments",
                                  hintStyle: TAppTextStyle.inter(
                                    weight: FontWeight.w400,
                                    color: QColors.lightGray400,
                                    fontSize: QSizes.fontSizeSmx ,
                                  ),

                                  /// FIX: search icon alignment
                                  suffixIcon: Icon(
                                    Icons.search,
                                    color: QColors.lightTextColor,
                                    size: 22,
                                  ),
                                  suffixIconConstraints: BoxConstraints(
                                    minWidth: 40,
                                    minHeight: 20,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(
                                      color: QColors.progressLight,
                                      width: 1,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(
                                      color: QColors.progressLight,
                                      width: 1,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      /// SEARCH FIELD

                      /// NOTIFICATION ICON
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.notifications_none,
                          color: QColors.progressLight,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: Text(
                      "Today: Wed 9 Oct 2025 | 13:00",
                      style: TAppTextStyle.inter(
                        color: QColors.lightTextColor,
                        fontSize: 20,
                        weight: FontWeight.w400,
                      ),
                    ),
                  ),
                  SizedBox(height: 30),

                  AppointmentCardWidget(patientName: 'John Doe', day: 'Wednesday', date: '08 Oct 2025 ', time: ' Time : 09: 30 AM', status: 'Completed',),
                  AppointmentCardWidget(patientName: 'Mary Okpe', day: 'Thursday', date: '09 Oct 2025 ', time: ' Time : 09: 30 AM', status: 'Pending',),
                  AppointmentCardWidget(patientName: 'Mikel Chinwike', day: 'Wednesday', date: '08 Oct 2025 ', time: ' Time : 09: 30 AM', status: 'Rejected',),


                ])
        ))));
  }
}
