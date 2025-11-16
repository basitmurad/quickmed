import 'package:flutter/material.dart';
import 'package:quickmed/utils/app_text_style.dart';
import 'package:quickmed/utils/widgets/TButton.dart';
import 'package:quickmed/utils/widgets/text_input_widget.dart';
import '../../../utils/device_utility.dart';
import '../../../utils/theme/colors/q_color.dart';
import 'account_type_screen.dart';

class AddressInfoScreen extends StatelessWidget {
  const AddressInfoScreen({super.key});

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
                          color: isDark ? Colors.white : Colors.black,
                          fontSize: 16,
                          weight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                ),

                const SizedBox(height: 26),

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

                Center(
                  child: Text(
                    "Address",
                    style: TAppTextStyle.inter(
                      color: isDark ? Colors.white70 : Colors.black87,
                      fontSize: 16,
                      weight: FontWeight.w500,
                    ),
                  ),
                ),

                const SizedBox(height: 28),

                TextInputWidget(
                    dark: isDark,
                    fillColor: Colors.transparent,
                    headerText: "Address Line 1",
                    hintText: "e.g. Torkia Street North bank"),

                TextInputWidget(
                    dark: isDark,
                    fillColor: Colors.transparent,
                    headerText: "City",
                    hintText: "e.g. Makurdi"),

                TextInputWidget(
                    dark: isDark,
                    fillColor: Colors.transparent,
                    headerText: "State",
                    hintText: "e.g. Benue"),

                TextInputWidget(
                    dark: isDark,
                    fillColor: Colors.transparent,
                    headerText: "Postcode",
                    hintText: "e.g. 970101"),

                TextInputWidget(
                    dark: isDark,
                    fillColor: Colors.transparent,
                    headerText: "Country",
                    hintText: "e.g. Nigeria"),

                const SizedBox(height: 28),

                QButton(
                  text: "Continue",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const AccountTypeScreen()),
                    );
                  },
                ),

                const SizedBox(height: 26),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
