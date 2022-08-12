import 'package:flutter/material.dart';

class AppTheme {
  final Color kCanvasColor = const Color(0xFFFFFFFF);
  final Color kTextColor = const Color(0xFF000000);
  final Color kPrimaryColor = const Color(0xFF322282);
  final Color kSecondaryTextColor = Colors.grey.shade700;
  final Color kWhiteText = const Color(0xFFFFFFFF);

  ThemeData buildTheme() {
    return ThemeData(
      canvasColor: kCanvasColor,
      primaryColor: kPrimaryColor,
      scaffoldBackgroundColor: kCanvasColor,
      appBarTheme: AppBarTheme(
        backgroundColor: kPrimaryColor,
        centerTitle: true,
        titleTextStyle: const TextStyle(
          fontSize: 24,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          primary: kPrimaryColor,
          textStyle: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          primary: kPrimaryColor,
          side: BorderSide(
            width: 1.0,
            color: kPrimaryColor,
          ),
          textStyle: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      radioTheme: RadioThemeData(
        fillColor: MaterialStateColor.resolveWith((states) => kPrimaryColor),
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateColor.resolveWith((states) => kPrimaryColor),
      ),
    );
  }
}
