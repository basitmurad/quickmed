import 'package:flutter/material.dart';

import '../../../routes/app_routes.dart';
import '../../../utils/app_text_style.dart';
import '../../../utils/image_path.dart';
import '../../../utils/sizes.dart';
import '../../../utils/theme/colors/q_color.dart';
import '../../../utils/widgets/TButton.dart';

class UpdateAvailabilityScreen extends StatelessWidget {
  const UpdateAvailabilityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,



      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child:  Column(
                children: [
                  /// ---------------- SEARCH BAR ----------------
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


                  const SizedBox(height: 20),

                  const Text(
                    "Calender With Booked dates Highlited",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                   SizedBox(height: 20),

                  /// ---------------- CALENDAR ICON ----------------
                  Icon(
                    Icons.calendar_month,
                    size: 130,
                    color: QColors.progressLight,
                  ),

                   SizedBox(height: 20),

                   Text(
                    "Selected Date: 10 Oct 2025",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: Colors.black87,
                    ),
                  ),

                  SizedBox(height: 25),

                   Text(
                    "Set Time Slots",
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                   SizedBox(height: 12),

                  /// ---------------- TIME SLOTS ----------------
                  buildTimeSlot("09:00 AM-11:00 AM | 09:00 AM-11:00 AM"),
                  buildTimeSlot("09:00 AM-11:00 AM | 09:00 AM-11:00 AM"),

                   SizedBox(height: 20),

                  /// ---------------- ADD ANOTHER SLOT ----------------
                  Text(
                    "+ Add Another Time Slot",
                    style: TextStyle(
                      color: Colors.blue.shade600,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  SizedBox(
                    height: 180,
                  ),

                  QButton(
                    text: 'Confirm',
                    onPressed: () {
                      AppRouter.router.push('/availabilityUpdatedScreen');

                      print("Confirm");
                    },
                  ),

                  /// ---------------- VERIFY BUTTON ----------------
                  const SizedBox(height: 26)
                ],
              ),
            ),
          ),
        ),

    );
  }

  /// ---------------- TIME SLOT TILE UI ----------------
  Widget buildTimeSlot(String text) {
    return Container(
      width: double.infinity,
      padding:  EdgeInsets.symmetric(vertical: 12),
      decoration:  BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Color(0xffd9d9d9)),
        ),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style:  TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
      ),
    );
  }
}
