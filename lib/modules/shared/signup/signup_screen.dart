import 'package:flutter/material.dart';
import 'package:quickmed/utils/app_text_style.dart';
import 'package:quickmed/utils/widgets/TButton.dart';
import 'package:quickmed/utils/widgets/text_input_widget.dart';
import '../../../utils/device_utility.dart';
import '../../../utils/theme/colors/q_color.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    bool isDark = TDeviceUtils.isDarkMode(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                /// ---------------- BACK BUTTON ----------------
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Row(
                    children: [
                      Icon(Icons.arrow_back, color: isDark ? Colors.white : Colors.black),
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

                const SizedBox(height: 26),

                /// ---------------- TITLE ----------------
                Center(
                  child: Text(
                    "Create Account",
                    style: TAppTextStyle.inter(
                      color: isDark ? Colors.white : Colors.black,
                      fontSize: 22,
                      weight: FontWeight.w700,
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                /// ---------------- SUBTITLE ----------------
                Center(
                  child: Text(
                    "Basic Information",
                    style: TAppTextStyle.inter(
                      color: isDark ? Colors.white70 : Colors.black87,
                      fontSize: 16,
                      weight: FontWeight.w500,
                    ),
                  ),
                ),

                const SizedBox(height: 28),

                /// ---------------- FIRST NAME ----------------
                TextInputWidget(
                  dark: isDark,
                  fillColor: Colors.transparent,
                  headerText: "First Name",
                ),
                SizedBox(height: 12,),

                /// ---------------- LAST NAME ----------------
                TextInputWidget(
                  dark: isDark,
                  fillColor: Colors.transparent,
                  headerText: "Last Name",
                ),
                SizedBox(height: 12,),

                /// ---------------- EMAIL ----------------
                TextInputWidget(
                  dark: isDark,
                  fillColor: Colors.transparent,
                  headerText: "Email",
                  isEmail: true,
                ),
                SizedBox(height: 12,),

                /// ---------------- PASSWORD ----------------
                TextInputWidget(
                  dark: isDark,
                  fillColor: Colors.transparent,
                  headerText: "Password",
                  isPassword: true,
                  hintText: "Strong password",
                ),
                SizedBox(height: 12,),

                /// ---------------- CONFIRM PASSWORD ----------------
                TextInputWidget(
                  dark: isDark,
                  fillColor: Colors.transparent,
                  headerText: "Confirm Password",
                  isPassword: true,
                ),
                SizedBox(height: 12,),

                /// ---------------- DATE OF BIRTH ----------------
                TextInputWidget(
                  dark: isDark,
                  fillColor: Colors.transparent,
                  headerText: "Date of Birth",
                ),
                SizedBox(height: 12,),

                /// ---------------- GENDER ----------------
                TextInputWidget(
                  dark: isDark,
                  fillColor: Colors.transparent,
                  headerText: "Gender",
                ),

                const SizedBox(height: 22),

                /// ---------------- CONTINUE BUTTON ----------------
                QButton(
                  text: "Continue",
                  onPressed: () {
                    // TODO: handle next steps
                  },
                ),

                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
