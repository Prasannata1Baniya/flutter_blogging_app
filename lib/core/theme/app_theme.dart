
import 'package:flutter/material.dart';

abstract final class AppTheme {
  // Brand Colors
  static const ink = Color(0xFF11162A);
  static const navy = Color(0xFF0F1428);
  static const purple = Color(0xFF7657F5);
  static const lightPurple = Color(0xFFDAD2FF);
  static const lavender = Color(0xFFF4F2FF);
  static const cream = Color(0xFFF9F9FD);

  // Supporting Colors
  static const textSecondary = Color(0xFF73758A);
  static const border = Color(0xFFE4E3F0);
  static const white = Colors.white;

  static ThemeData get light => ThemeData(
    useMaterial3: true,

    scaffoldBackgroundColor: cream,

    colorScheme: ColorScheme.fromSeed(
      seedColor: purple,
      brightness: Brightness.light,
      surface: cream,
      primary: purple,
      onPrimary: white,
      secondary: lightPurple,
      onSurface: ink,
    ),

    textTheme: const TextTheme(
      displaySmall: TextStyle(
        fontSize: 38,
        height: 1.05,
        fontWeight: FontWeight.w800,
        letterSpacing: -1.5,
        color: ink,
      ),

      headlineMedium: TextStyle(
        fontSize: 25,
        height: 1.15,
        fontWeight: FontWeight.w800,
        letterSpacing: -0.6,
        color: ink,
      ),

      titleLarge: TextStyle(
        fontSize: 19,
        height: 1.2,
        fontWeight: FontWeight.w800,
        color: ink,
      ),

      bodyLarge: TextStyle(
        fontSize: 16,
        height: 1.55,
        color: ink,
      ),

      bodyMedium: TextStyle(
        fontSize: 14,
        height: 1.4,
        color: textSecondary,
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: white,

      contentPadding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 17,
      ),

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(
          color: border,
        ),
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(
          color: border,
        ),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(
          color: purple,
          width: 1.6,
        ),
      ),

      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(
          color: Colors.redAccent,
        ),
      ),

      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(
          color: Colors.redAccent,
          width: 1.6,
        ),
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: purple,
        foregroundColor: white,
        elevation: 0,
        minimumSize: const Size(double.infinity, 56),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        textStyle: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w700,
        ),
      ),
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: white,
      indicatorColor: lightPurple,
      elevation: 0,
      labelTextStyle: WidgetStatePropertyAll(
        TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: ink,
        ),
      ),
    ),
  );
}










/*import 'package:flutter/material.dart';
abstract final class AppTheme {
  static const ink = Color(0xFF172026);
  static const cream = Color(0xFFF8F6F1);
  static const coral = Color(0xFFED6A5A);
  static const sage = Color(0xFFB8C8AD);
  static const lavender = Color(0xFFDAD7F6);

  static ThemeData get light => ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: cream,
    colorScheme: ColorScheme.fromSeed(
      seedColor: coral,
      brightness: Brightness.light,
      surface: cream,
    ),
    textTheme: const TextTheme(
      displaySmall: TextStyle(
        fontSize: 38,
        height: 1.05,
        fontWeight: FontWeight.w800,
        letterSpacing: -1.5,
        color: ink,
      ),
      headlineMedium: TextStyle(
        fontSize: 25,
        height: 1.15,
        fontWeight: FontWeight.w800,
        letterSpacing: -0.6,
        color: ink,
      ),
      titleLarge: TextStyle(
        fontSize: 19,
        height: 1.2,
        fontWeight: FontWeight.w800,
        color: ink,
      ),
      bodyLarge: TextStyle(fontSize: 16, height: 1.55, color: ink),
      bodyMedium: TextStyle(
        fontSize: 14,
        height: 1.4,
        color: Color(0xFF657077),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 17),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(color: Color(0xFFE2E0DA)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(color: Color(0xFFE2E0DA)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(color: coral, width: 1.6),
      ),
    ),
  );
}
*/