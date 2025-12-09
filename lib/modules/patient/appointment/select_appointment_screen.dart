// import 'package:flutter/material.dart';
// import 'package:quickmed/modules/patient/appointment/widgets/doctor_card.dart';
// import 'package:quickmed/modules/patient/appointment/widgets/time_slot_grid.dart';
// import '../../../utils/app_text_style.dart';
// import '../../../utils/device_utility.dart';
// import '../../../utils/widgets/TButton.dart';
// import '../../../utils/theme/colors/q_color.dart';
//
// class SelectAppointmentScreen extends StatefulWidget {
//   const SelectAppointmentScreen({super.key});
//
//   @override
//   State<SelectAppointmentScreen> createState() =>
//       _SelectAppointmentScreenState();
// }
//
// class _SelectAppointmentScreenState extends State<SelectAppointmentScreen> {
//   final TextEditingController dateController = TextEditingController();
//   DateTime? selectedDate;
//
//   int? selectedSlotIndex;
//
//   final List<String> slots = [
//     "9:00 AM - 11:00 AM",
//     "11:00 AM - 11:30 AM",
//     "11:30 AM - 12:00 PM",
//     "12:00 PM - 12:30 PM",
//     "12:30 PM - 1:00 PM",
//     "1:00 PM - 1:30 PM",
//   ];
//
//   @override
//   void dispose() {
//     dateController.dispose();
//     super.dispose();
//   }
//
//   Future<void> pickDate() async {
//     final now = DateTime.now();
//     final picked = await showDatePicker(
//       context: context,
//       initialDate: selectedDate ?? now,
//       firstDate: now,
//       lastDate: DateTime(2100),
//     );
//
//     if (picked != null) {
//       setState(() {
//         selectedDate = picked;
//         dateController.text =
//         "${picked.day}/${picked.month}/${picked.year}";
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final isDark = TDeviceUtils.isDarkMode(context);
//
//     return Scaffold(
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 14),
//           child: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const SizedBox(height: 12),
//
//                 GestureDetector(
//                   onTap: () => Navigator.pop(context),
//                   child: Row(
//                     children: [
//                       Icon(Icons.arrow_back,
//                           color: isDark ? Colors.white : Colors.black),
//                       const SizedBox(width: 6),
//                       Text(
//                         "Go Back",
//                         style: TAppTextStyle.inter(
//                           fontSize: 16,
//                           weight: FontWeight.w500,
//                           color: isDark ? Colors.white : Colors.black,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//
//                 const SizedBox(height: 26),
//
//                 Center(
//                   child: Text(
//                     "Book Appointment",
//                     style: TAppTextStyle.inter(
//                       fontSize: 20,
//                       weight: FontWeight.w600,
//                       color: isDark ? Colors.white : Colors.black,
//                     ),
//                   ),
//                 ),
//
//                 const SizedBox(height: 40),
//
//                 Center(
//                   child: Text(
//                     "Selected Doctor",
//                     style: TAppTextStyle.inter(
//                       fontSize: 15,
//                       weight: FontWeight.w400,
//                       color: isDark ? Colors.white70 : Colors.black87,
//                     ),
//                   ),
//                 ),
//
//                 const SizedBox(height: 20),
//
//                 /// Doctor Widget
//                 Center(
//                   child: DoctorCard(
//                     name: "Dr Sara John",
//                     speciality: "Cardiology",
//                     miles: "1.8 miles",
//                     onDirectionTap: () {
//                       print("Opening maps for Dr Sara John");
//                     },
//                   ),
//                 ),
//
//                 const SizedBox(height: 40),
//
//                 Text(
//                   "Pick Appointment Date",
//                   style: TAppTextStyle.inter(
//                     fontSize: 15,
//                     weight: FontWeight.w500,
//                     color: isDark ? Colors.white : Colors.black,
//                   ),
//                 ),
//
//                 const SizedBox(height: 10),
//
//                 TextField(
//                   controller: dateController,
//                   readOnly: true,
//                   onTap: pickDate,
//                   decoration: InputDecoration(
//                     hintText: "Date",
//                     suffixIcon: const Icon(Icons.calendar_month),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                   ),
//                 ),
//
//                 const SizedBox(height: 28),
//
//                 Center(
//                   child: Text(
//                     "Available Time Slots",
//                     style: TAppTextStyle.inter(
//                       fontSize: 15,
//                       weight: FontWeight.w500,
//                       color: isDark ? Colors.white : Colors.black,
//                     ),
//                   ),
//                 ),
//
//
//
//                 TimeSlotGrid(
//                   slots: slots,
//                   selectedSlotIndex: selectedSlotIndex,
//                   onSlotSelected: (index) {
//                     setState(() {
//                       selectedSlotIndex = index;
//                     });
//                   },
//                 ),
//
//                 const SizedBox(height: 30),
//
//                 QButton(
//                   text: "Continue",
//                   onPressed: () {},
//                 ),
//
//                 const SizedBox(height: 20),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//
//
// }


import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quickmed/modules/patient/appointment/widgets/doctor_card.dart';
import 'package:quickmed/modules/patient/appointment/widgets/time_slot_grid.dart';
import '../../../utils/app_text_style.dart';
import '../../../utils/device_utility.dart';
import '../../../utils/widgets/TButton.dart';
import '../../../utils/theme/colors/q_color.dart';

class SelectAppointmentScreen extends StatefulWidget {
  final Map<String, dynamic>? doctorData;

  const SelectAppointmentScreen({
    super.key,
    this.doctorData,
  });

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

  // Get doctor data from route or use defaults
  String get doctorName => widget.doctorData?['doctorName'] ?? 'Dr Sara John';
  String get specialization => widget.doctorData?['specialization'] ?? 'Cardiology';
  String get miles => widget.doctorData?['miles'] ?? '1.8 miles';
  String get hospital => widget.doctorData?['hospital'] ?? 'City General Hospital';
  String get consultationFee => widget.doctorData?['consultationFee'] ?? '\$80';

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
        dateController.text = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  String _formatDateTime() {
    if (selectedDate == null || selectedSlotIndex == null) return '';

    // Get day name
    final days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
    final dayName = days[selectedDate!.weekday - 1];

    // Get month name
    final months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    final monthName = months[selectedDate!.month - 1];

    // Get time slot
    final timeSlot = slots[selectedSlotIndex!];
    final startTime = timeSlot.split(' - ')[0];

    return '$dayName ${selectedDate!.day}${_getDaySuffix(selectedDate!.day)} $monthName $startTime';
  }

  String _getDaySuffix(int day) {
    if (day >= 11 && day <= 13) return 'th';
    switch (day % 10) {
      case 1: return 'st';
      case 2: return 'nd';
      case 3: return 'rd';
      default: return 'th';
    }
  }

  void _handleContinue() {
    // Validate date and time slot selection
    if (selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please select an appointment date'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    if (selectedSlotIndex == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please select a time slot'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    // Navigate to success screen with booking details
    context.push(
      '/appointmentSuccessScreen',
      extra: {
        'doctorName': doctorName,
        'specialization': specialization,
        'dateTime': _formatDateTime(),
        'hospital': hospital,
        'consultationFee': consultationFee,
      },
    );
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

                /// Back Button
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

                /// Title
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

                /// Selected Doctor Label
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

                /// Doctor Card Widget
                Center(
                  child: DoctorCard(
                    name: doctorName,
                    speciality: specialization,
                    miles: miles,
                    onDirectionTap: () {
                      print("Opening maps for $doctorName");
                    },
                  ),
                ),

                const SizedBox(height: 40),

                /// Pick Date Label
                Text(
                  "Pick Appointment Date",
                  style: TAppTextStyle.inter(
                    fontSize: 15,
                    weight: FontWeight.w500,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),

                const SizedBox(height: 10),

                /// Date Picker Field
                TextField(
                  controller: dateController,
                  readOnly: true,
                  onTap: pickDate,
                  decoration: InputDecoration(
                    hintText: "Select Date",
                    suffixIcon: const Icon(Icons.calendar_month),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),

                const SizedBox(height: 28),

                /// Time Slots Label
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

                /// Time Slot Grid
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

                /// Continue Button
                QButton(
                  text: "Continue",
                  onPressed: _handleContinue,
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
