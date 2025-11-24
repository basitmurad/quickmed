import 'package:flutter/material.dart';
import 'package:quickmed/utils/app_text_style.dart';
import 'package:quickmed/utils/device_utility.dart';
import 'package:quickmed/utils/theme/colors/q_color.dart';

enum Status { accepted, rejected, complete, noShow }

class AppointmentWidget extends StatelessWidget {
  final String date;
  final String time;
  final Status status;
  final VoidCallback? onTap;

  const AppointmentWidget({
    required this.date,
    required this.time,
    required this.status,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    bool isDark = TDeviceUtils.isDarkMode(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 420,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: QColors.brand100),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Text(
                    "Date : $date | $time",
                    style: TAppTextStyle.inter(
                      color: isDark ? QColors.lightBackground : Colors.black,
                      fontSize: 20,
                      weight: FontWeight.w400,
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Row(
                  children: [
                    Text(
                      "Status : ",
                      style: TAppTextStyle.inter(
                        color: isDark ? QColors.lightBackground : Colors.black,
                        fontSize: 20,
                        weight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      _appointmentStatus(status),
                      style: TAppTextStyle.inter(
                        color: isDark ? QColors.lightBackground : Colors.black,
                        fontSize: 20,
                        weight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

String _appointmentStatus(Status status) {
  if (status == Status.accepted) return "✅ Accepted";
  if (status == Status.rejected) return "❌ Rejected";
  if (status == Status.complete) return "✅ Completed";
  if (status == Status.noShow) return "🚫 No Show";
  return "unknown";
}
