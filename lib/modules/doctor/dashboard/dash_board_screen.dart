import 'package:flutter/material.dart';
import 'package:quickmed/modules/doctor/widgets/summary_item.dart';
import 'package:quickmed/utils/app_text_style.dart';
import 'package:quickmed/utils/image_path.dart';

import '../../../routes/app_routes.dart';
import '../../../utils/sizes.dart';
import '../../../utils/theme/colors/q_color.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: QSizes.lg),

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
                SizedBox(height: 25),
                Text(
                  "Next Appointment",
                  style: TAppTextStyle.inter(
                    weight: FontWeight.w700,
                    fontSize: 19,
                    color: QColors.info900,
                  ),
                ),
                SizedBox(height: 12),
                Container(
                  width: 384,

                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade300, width: 1),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Date : 11 Oct 2025 10:30 AM",
                        style: TAppTextStyle.inter(
                          fontSize: 15,
                          weight: FontWeight.w600,
                          color: QColors.iconColorDark,
                        ),
                      ),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          Text(
                            "Patient - ",
                            style: TAppTextStyle.inter(
                              fontSize: 15,
                              weight: FontWeight.w500,
                              color: QColors.iconColorDark,
                            ),
                          ),
                          Text(
                            "John Omeh",
                            style: TAppTextStyle.inter(
                              fontSize: 15,
                              weight: FontWeight.bold,
                              color: QColors.containerbackgroundColorLightMode,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 25),
                Center(
                  child: Text(
                    "Summary",
                    style: TAppTextStyle.inter(
                      fontSize: 17,
                      weight: FontWeight.bold,
                      color: QColors.info900,
                    ),
                  ),
                ),
                SizedBox(height: 18),
                SummaryItem(title: "Total Appointment", value: "30"),
                SummaryItem(
                  icon: Icons.check_circle,
                  color: Colors.green,
                  title: "Completed",
                  value: "20",
                ),
                SummaryItem(
                  icon: Icons.access_time,
                  color: Colors.blue,
                  title: "Pending",
                  value: "4",
                ),
                SummaryItem(
                  icon: Icons.block,
                  color: Colors.red,
                  title: "Rejected",
                  value: "1",
                ),
                SummaryItem(
                  icon: Icons.cancel,
                  color: Colors.redAccent,
                  title: "Cancelled",
                  value: "3",
                ),
                SummaryItem(
                  icon: Icons.do_not_disturb,
                  color: Colors.orange,
                  title: "No Show",
                  value: "2",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
