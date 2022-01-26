import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

mixin AppColors {
  static Color primayColor = const Color(0xFF1c3159);
  static Color primaryTextColor = const Color(0xFF1c3159);
  static Color secondaryTextColor = const Color(0xFFBABFC4);
}

mixin AppFonts {
  static TextStyle primaryFont = GoogleFonts.quicksand();
}

mixin AppTextFields {
  static InputDecoration minimalTextFieldDecoration = InputDecoration(
    focusColor: Colors.black,
    hintText: 'Enter a value',
    helperStyle: TextStyle(
      color: Colors.green.shade400,
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: AppColors.primayColor,
        width: 3.0,
      ),
    ),
    contentPadding: const EdgeInsets.symmetric(
      vertical: 10.0,
      horizontal: 0,
    ),
    labelStyle: TextStyle(
      color: AppColors.primayColor,
    ),
    hintStyle: TextStyle(
      color: AppColors.secondaryTextColor,
    ),
  );
}
