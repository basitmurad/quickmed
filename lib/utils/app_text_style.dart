import 'package:flutter/material.dart'; // Add this to your app_text_style.dart file

class TAppTextStyle {
  static inter({
    required Color color,
    required double fontSize,
    required FontWeight weight,
    double height = 1.0,
    bool shouldUnderline = false,
    double letterSpacing = 0.0, // <-- added
  }) {
    return TextStyle(
      height: height,
      color: color,
      fontWeight: weight,
      fontSize: fontSize,
      fontFamily: AppFontFamilies.inter,
      letterSpacing: letterSpacing, // <-- added
      decoration: shouldUnderline ? TextDecoration.underline : TextDecoration.none,
      decorationColor: color,
    );
  }
}

class AppFontFamilies {
  static String inter = 'Inter'; // Add this line
}
