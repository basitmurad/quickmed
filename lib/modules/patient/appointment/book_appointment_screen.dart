// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import '../../../routes/app_routes.dart';
// import '../../../utils/app_text_style.dart';
// import '../../../utils/device_utility.dart';
// import '../../../utils/image_path.dart';
// import '../../../utils/theme/colors/q_color.dart';
// import '../../../utils/widgets/TButton.dart';
// import '../../../utils/widgets/text_input_widget.dart';
// import '../dashboard/widgets/profile_pic.dart';
//
// class BookAppointmentScreen extends StatefulWidget {
//   const BookAppointmentScreen({super.key});
//
//   @override
//   State<BookAppointmentScreen> createState() => _BookAppointmentScreenState();
// }
//
// class _BookAppointmentScreenState extends State<BookAppointmentScreen> {
//   final TextEditingController historyController = TextEditingController();
//   final TextEditingController symptomsController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     final bool isDark = TDeviceUtils.isDarkMode(context);
//
//     return Scaffold(
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 18),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               /// Back button
//               SizedBox(height: 12),
//               Row(
//                 mainAxisAlignment:MainAxisAlignment.spaceBetween,
//                 children: [
//                   ProfilePic(
//                     imagePath: QImagesPath.profileImg,
//                     onTap: () => context.push('/patientProfileScreen'),
//                   ),
//
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 5),
//                     child: Center(
//                       child: IconButton(
//                         onPressed: () {
//                           AppRouter.router.push('/notificationScreen');
//
//
//                         },
//                         icon: Icon(
//                           Icons.notifications_outlined,
//                           color: QColors.newPrimary500,
//                           size: 35,
//                         ),
//                       ),
//                     ),
//                   ),
//
//                   /// ---------------- NOTIFICATION BUTTON ---------------- ///
//                 ],
//               ),
//               // GestureDetector(
//               //   onTap: () => Navigator.pop(context),
//               //   child: Row(
//               //     children: [
//               //       Icon(
//               //         Icons.arrow_back,
//               //         color: isDark ? Colors.white : Colors.black,
//               //       ),
//               //       const SizedBox(width: 6),
//               //       Text(
//               //         "Go Back",
//               //         style: TAppTextStyle.inter(
//               //           color: isDark ? Colors.white : Colors.black,
//               //           fontSize: 16,
//               //           weight: FontWeight.w500,
//               //         ),
//               //       ),
//               //     ],
//               //   ),
//               // ),
//
//               const SizedBox(height: 26),
//
//               /// Title
//               Center(
//                 child: Text(
//                   "Book Appointment",
//                   style: TAppTextStyle.inter(
//                     fontSize: 20,
//                     weight: FontWeight.w600,
//                     color: isDark ? Colors.white : Colors.black,
//                   ),
//                 ),
//               ),
//
//               const SizedBox(height: 30),
//
//               /// --- Medical History ---
//               TextInputWidget(
//                 controller: historyController,
//                 headerText: "Enter Your Medical History (optional)",
//                 hintText: "e.g. Hypertension",
//                 dark: isDark,
//                 fillColor: Colors.transparent,
//               ),
//
//               const SizedBox(height: 30),
//
//               /// --- Symptoms ---
//               TextInputWidget(
//                 controller: symptomsController,
//                 headerText: "Enter Current Symptoms",
//                 hintText: "e.g. Cough, Chest pain, Head ache etc",
//                 dark: isDark,
//                 fillColor: Colors.transparent,
//               ),
//
//               Spacer(),
//
//               /// Continue button
//               QButton(
//                 text: "Continue",
//                 onPressed: () {
//                   // AppRouter.router.push('/systemSuggestingDoctorScreen');
//                   // AppRouter.router.push('/noAvailableDoctorScreen');
//                   AppRouter.router.push('/systemSuggestingDoctorScreen');
//                   // AppRouter.router.push('/selectAppointmentScreen');
//
//                   // SystemSuggestingDoctorScreen
//                   // You can add validation or submit here
//                 },
//               ),
//
//               const SizedBox(height: 20),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../routes/app_routes.dart';
import '../../../utils/app_text_style.dart';
import '../../../utils/device_utility.dart';
import '../../../utils/image_path.dart';
import '../../../utils/theme/colors/q_color.dart';
import '../../../utils/widgets/TButton.dart';
import '../../../utils/widgets/text_input_widget.dart';
import '../dashboard/widgets/profile_pic.dart';

class BookAppointmentScreen extends StatefulWidget {
  const BookAppointmentScreen({super.key});

  @override
  State<BookAppointmentScreen> createState() => _BookAppointmentScreenState();
}

class _BookAppointmentScreenState extends State<BookAppointmentScreen> {
  final TextEditingController historyController = TextEditingController();
  final TextEditingController symptomsController = TextEditingController();

  @override
  void dispose() {
    historyController.dispose();
    symptomsController.dispose();
    super.dispose();
  }

  void _handleContinue() {
    // Validate that symptoms are entered
    if (symptomsController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter your current symptoms'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    // Navigate to doctor suggestion screen with data
    AppRouter.router.push(
      '/systemSuggestingDoctorScreen',
      extra: {
        'medicalHistory': historyController.text.trim(),
        'symptoms': symptomsController.text.trim(),
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = TDeviceUtils.isDarkMode(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Top Bar
              SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ProfilePic(
                    imagePath: QImagesPath.profileImg,
                    onTap: () => context.push('/patientProfileScreen'),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Center(
                      child: IconButton(
                        onPressed: () {
                          AppRouter.router.push('/notificationScreen');
                        },
                        icon: Icon(
                          Icons.notifications_outlined,
                          color: QColors.newPrimary500,
                          size: 35,
                        ),
                      ),
                    ),
                  ),
                ],
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

              const SizedBox(height: 30),

              /// Medical History Input
              TextInputWidget(
                controller: historyController,
                headerText: "Enter Your Medical History (optional)",
                hintText: "e.g. Hypertension, Diabetes",
                dark: isDark,
                fillColor: Colors.transparent,
              ),

              const SizedBox(height: 30),

              /// Symptoms Input
              TextInputWidget(
                controller: symptomsController,
                headerText: "Enter Current Symptoms*",
                hintText: "e.g. Cough, Chest pain, Head ache etc",
                dark: isDark,
                fillColor: Colors.transparent,
              ),

              Spacer(),

              /// Continue button
              QButton(
                text: "Continue",
                onPressed: _handleContinue,
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}