import 'package:flutter/material.dart';
import 'package:quickmed/utils/app_text_style.dart';
import 'package:quickmed/utils/widgets/TButton.dart';
import 'package:quickmed/utils/widgets/text_input_widget.dart';
import '../../../utils/device_utility.dart';
import '../../../utils/theme/colors/q_color.dart';

class AccountTypeScreen extends StatefulWidget {
  const AccountTypeScreen({super.key});

  @override
  State<AccountTypeScreen> createState() => _AccountTypeScreenState();
}

class _AccountTypeScreenState extends State<AccountTypeScreen> {
  String selectedType = "Patient";
  bool acceptTerms = false;

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
                  "Chose Account Type",
                  style: TAppTextStyle.inter(
                    color: isDark ? Colors.white70 : Colors.black,
                    fontSize: 16,
                    weight: FontWeight.w600,
                  ),
                ),
              ),

              const SizedBox(height: 18),

              /// Patient & Doctor Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _typeButton("Patient", isDark),
                  _typeButton("Doctor", isDark),
                ],
              ),

              const SizedBox(height: 32),

              Center(
                child: Text(
                  "Medical History",
                  style: TAppTextStyle.inter(
                    color: isDark ? Colors.white70 : Colors.black,
                    fontSize: 16,
                    weight: FontWeight.w600,
                  ),
                ),
              ),

              const SizedBox(height: 16),

              TextInputWidget(
                dark: isDark,
                fillColor: Colors.transparent,
                headerText: "Enter Health Issues (optional)",
                hintText: "e.g. Hypertension",
              ),

              const SizedBox(height: 24),

              Row(
                children: [
                  Checkbox(
                    value: acceptTerms,
                    activeColor: QColors.primary,
                    onChanged: (val) {
                      setState(() => acceptTerms = val!);
                    },
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() => acceptTerms = !acceptTerms);
                    },
                    child: Text(
                      "Accept terms and Conditions",
                      style: TAppTextStyle.inter(
                        color: QColors.primary,
                        fontSize: 16,
                        weight: FontWeight.w500,
                        shouldUnderline: true,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 32),


            ],
          ),
        ),
      ),
    );
  }

  Widget _typeButton(String type, bool isDark) {
    bool selected = selectedType == type;

    return GestureDetector(
      onTap: () => setState(() => selectedType = type),
      child: Container(
        width: 120,
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: selected ? QColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color: selected ? QColors.primary : Colors.grey.shade400),
        ),
        child: Center(
          child: Text(
            type,
            style: TAppTextStyle.inter(
              color: selected
                  ? Colors.white
                  : (isDark ? Colors.white : Colors.black),
              fontSize: 16,
              weight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
