// import 'package:flutter/material.dart';
// import 'package:quickmed/modules/shared/signup/account_type_screen.dart';
// import 'package:quickmed/modules/shared/signup/address_info_screen.dart';
// import 'package:quickmed/modules/shared/signup/basic_information_screen.dart';
// import 'package:quickmed/utils/app_text_style.dart';
// import 'package:quickmed/utils/widgets/TButton.dart';
// import '../../../routes/app_routes.dart';
// import '../../../utils/device_utility.dart';
// import '../../../utils/theme/colors/q_color.dart';
//
// class SignUpScreen extends StatefulWidget {
//   const SignUpScreen({super.key});
//
//   @override
//   State<SignUpScreen> createState() => _SignUpScreenState();
// }
//
// class _SignUpScreenState extends State<SignUpScreen> {
//   final PageController _pageController = PageController();
//   int currentPage = 0;
//
//   void nextPage() {
//     if (currentPage < 2) {
//       _pageController.nextPage(
//         duration: const Duration(milliseconds: 300),
//         curve: Curves.easeInOut,
//       );
//     }
//   }
//
//   void previousPage() {
//     if (currentPage > 0) {
//       _pageController.previousPage(
//         duration: const Duration(milliseconds: 300),
//         curve: Curves.easeInOut,
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     bool isDark = TDeviceUtils.isDarkMode(context);
//
//     return Scaffold(
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
//           child: Column(
//             children: [
//               SizedBox(height: 6,),
//               /// ---------------- BACK BUTTON ----------------
//               Align(
//                 alignment: Alignment.centerLeft,
//                 child: GestureDetector(
//                   onTap: () {
//                     if (currentPage == 0) {
//                       Navigator.pop(context);
//                     } else {
//                       previousPage();
//                     }
//                   },
//                   child: Row(
//                     children: [
//                       Icon(Icons.arrow_back,
//                           color: isDark ? Colors.white : Colors.black),
//                       const SizedBox(width: 6),
//                       Text(
//                         "Go Back",
//                         style: TAppTextStyle.inter(
//                           color: isDark ? Colors.white : QColors.lightGray800,
//                           fontSize: 16,
//                           weight: FontWeight.w500,
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//
//               const SizedBox(height: 20),
//
//               /// ---------------- PAGEVIEW ----------------
//               Expanded(
//                 child: PageView(
//                   controller: _pageController,
//                   physics: const BouncingScrollPhysics(), // swipe enabled
//                   onPageChanged: (index) {
//                     setState(() => currentPage = index);
//                   },
//                   children: const [
//                     BasicInformationScreen(),
//                     AddressInfoScreen(),
//                     AccountTypeScreen(),
//                   ],
//                 ),
//               ),
//
//               const SizedBox(height: 12),
//
//               /// ---------------- DOTS INDICATOR ----------------
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: List.generate(
//                   3,
//                       (index) => AnimatedContainer(
//                     duration: const Duration(milliseconds: 300),
//                     margin: const EdgeInsets.symmetric(horizontal: 4),
//                     height: 8,
//                     width: currentPage == index ? 22 : 8,
//                     decoration: BoxDecoration(
//                       color: currentPage == index
//                           ? QColors.primary
//                           : Colors.grey,
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                   ),
//                 ),
//               ),
//
//               const SizedBox(height: 16),
//
//               /// ---------------- BUTTON ----------------
//               QButton(
//                 text: currentPage == 2 ? "Finish" : "Continue",
//                 onPressed: () {
//                   if (currentPage == 2) {
//                     // TODO: Save all form data + submit
//
//                     AppRouter.router.push('/oTPVerificationScreen');
//
//                     print("Submit all data");
//                   } else {
//                     nextPage();
//                   }
//                 },
//               ),
//
//               const SizedBox(height: 22),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickmed/modules/shared/signup/account_type_screen.dart';
import 'package:quickmed/modules/shared/signup/address_info_screen.dart';
import 'package:quickmed/modules/shared/signup/basic_information_screen.dart';
import 'package:quickmed/utils/app_text_style.dart';
import 'package:quickmed/utils/widgets/TButton.dart';
import '../../../routes/app_routes.dart';
import '../../../utils/device_utility.dart';
import '../../../utils/theme/colors/q_color.dart';
import '../../provider/SignUpProvider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final PageController _pageController = PageController();
  int currentPage = 0;

  void nextPage() {
    if (currentPage < 2) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void previousPage() {
    if (currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  /// Validate current page before proceeding
  bool validateAndProceed(SignUpProvider provider) {
    bool isValid = provider.validatePage(currentPage);

    if (!isValid) {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fix the errors before continuing'),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 2),
        ),
      );
    }

    return isValid;
  }

  /// Handle final submission
  void handleSubmit(SignUpProvider provider) async {
    // Validate the final page
    if (!validateAndProceed(provider)) {
      return;
    }

    // Get all form data
    final formData = provider.getAllFormData();

    // Show loading dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    // Simulate API call (replace with your actual API call)
    await Future.delayed(const Duration(seconds: 2));

    // Close loading dialog
    if (mounted) Navigator.of(context).pop();

    // Debug: Print form data
    print("=== SIGNUP FORM DATA ===");
    formData.forEach((key, value) {
      print("$key: $value");
    });
    print("========================");

    // TODO: Send data to your backend API
    // Example:
    // final response = await AuthService.register(formData);
    // if (response.success) {
    //   Navigate to OTP screen
    // }

    // Navigate to OTP verification screen
    if (mounted) {
      AppRouter.router.push('/accountCreationSuccessScreen');
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = TDeviceUtils.isDarkMode(context);
    final provider = Provider.of<SignUpProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: Column(
            children: [
              const SizedBox(height: 6),

              /// ---------------- BACK BUTTON ----------------
              Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: () {
                    if (currentPage == 0) {
                      // Show confirmation dialog before exiting
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text("Cancel Registration?"),
                          content: const Text(
                            "Are you sure you want to cancel? Your progress will be lost.",
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text("No"),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context); // Close dialog
                                provider.resetForm(); // Clear form
                                Navigator.pop(context); // Exit signup
                              },
                              child: const Text(
                                "Yes, Cancel",
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      previousPage();
                    }
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

              const SizedBox(height: 20),

              /// ---------------- PAGEVIEW ----------------
              Expanded(
                child: PageView(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(), // Disable swipe
                  onPageChanged: (index) {
                    setState(() => currentPage = index);
                  },
                  children: const [
                    BasicInformationScreen(),
                    AddressInfoScreen(),
                    AccountTypeScreen(),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              /// ---------------- DOTS INDICATOR ----------------
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  3,
                      (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    height: 8,
                    width: currentPage == index ? 22 : 8,
                    decoration: BoxDecoration(
                      color: currentPage == index
                          ? QColors.primary
                          : Colors.grey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              /// ---------------- BUTTON ----------------
              QButton(
                text: currentPage == 2 ? "Finish" : "Continue",
                onPressed: () {
                  if (currentPage == 2) {
                    // Final page - submit data
                    handleSubmit(provider);
                  } else {
                    // Not final page - validate and proceed
                    if (validateAndProceed(provider)) {
                      nextPage();
                    }
                  }
                },
              ),

              const SizedBox(height: 22),
            ],
          ),
        ),
      ),
    );
  }
}
