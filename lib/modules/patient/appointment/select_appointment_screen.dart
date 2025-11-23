import 'package:flutter/material.dart';
import 'package:quickmed/modules/patient/appointment/widgets/doctor_card.dart';
import 'package:quickmed/modules/patient/appointment/widgets/time_slot_grid.dart';
import '../../../utils/app_text_style.dart';
import '../../../utils/device_utility.dart';
import '../../../utils/widgets/TButton.dart';
import '../../../utils/theme/colors/q_color.dart';

class SelectAppointmentScreen extends StatefulWidget {
  const SelectAppointmentScreen({super.key});

  @override
  State<SelectAppointmentScreen> createState() =>
      _SelectAppointmentScreenState();
}

class _SelectAppointmentScreenState extends State<SelectAppointmentScreen> {
  final TextEditingController dateController = TextEditingController();
  DateTime? selectedDate;

  int? selectedSlotIndex;

  final List<String> slots = [
    "9:00 AM - 11:00 AM",
    "11:00 AM - 11:30 AM",
    "11:30 AM - 12:00 PM",
    "12:00 PM - 12:30 PM",
    "12:30 PM - 1:00 PM",
    "1:00 PM - 1:30 PM",
  ];

  @override
  void dispose() {
    dateController.dispose();
    super.dispose();
  }

  Future<void> pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? now,
      firstDate: now,
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
        dateController.text =
        "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = TDeviceUtils.isDarkMode(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 12),

                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Row(
                    children: [
                      Icon(Icons.arrow_back,
                          color: isDark ? Colors.white : Colors.black),
                      const SizedBox(width: 6),
                      Text(
                        "Go Back",
                        style: TAppTextStyle.inter(
                          fontSize: 16,
                          weight: FontWeight.w500,
                          color: isDark ? Colors.white : Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 26),

                Center(
                  child: Text(
                    "Book Appointment",
                    style: TAppTextStyle.inter(
                      fontSize: 20,
                      weight: FontWeight.w600,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                Center(
                  child: Text(
                    "Selected Doctor",
                    style: TAppTextStyle.inter(
                      fontSize: 15,
                      weight: FontWeight.w400,
                      color: isDark ? Colors.white70 : Colors.black87,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                /// Doctor Widget
                Center(
                  child: DoctorCard(
                    name: "Dr Sara John",
                    speciality: "Cardiology",
                    miles: "1.8 miles",
                    onDirectionTap: () {
                      print("Opening maps for Dr Sara John");
                    },
                  ),
                ),

                const SizedBox(height: 40),

                Text(
                  "Pick Appointment Date",
                  style: TAppTextStyle.inter(
                    fontSize: 15,
                    weight: FontWeight.w500,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),

                const SizedBox(height: 10),

                TextField(
                  controller: dateController,
                  readOnly: true,
                  onTap: pickDate,
                  decoration: InputDecoration(
                    hintText: "Date",
                    suffixIcon: const Icon(Icons.calendar_month),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),

                const SizedBox(height: 28),

                Center(
                  child: Text(
                    "Available Time Slots",
                    style: TAppTextStyle.inter(
                      fontSize: 15,
                      weight: FontWeight.w500,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                ),



                TimeSlotGrid(
                  slots: slots,
                  selectedSlotIndex: selectedSlotIndex,
                  onSlotSelected: (index) {
                    setState(() {
                      selectedSlotIndex = index;
                    });
                  },
                ),

                const SizedBox(height: 30),

                QButton(
                  text: "Continue",
                  onPressed: () {},
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }



}
