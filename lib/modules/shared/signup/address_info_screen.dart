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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [



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


            ],
          ),
        ),
      ),
    );
  }
}
