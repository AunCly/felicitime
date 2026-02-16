import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:felicitime/config/colors.dart';

const gapHNormal = SizedBox(height: 10);
const gapHSmall = SizedBox(height: 5);
const gapHLarge = SizedBox(height: 20);

const gapWNormal = SizedBox(width: 10);
const gapWSmall = SizedBox(width: 5);
const gapWLarge = SizedBox(width: 20);

class AppTheme {

  static const Color appBlack = Color(0xFF2E2E2E);
  static const Color appWhite = Color(0xFFFFFFFF);
  static const Color appGrey = Color(0xFFF2F4F5);

  static final light = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFFbeaffc),

      primary: AppColors.appPurple,
      onPrimary: AppColors.appWhite,

      secondary: AppColors.appOrange,
      onSecondary: AppColors.appWhite,

      surface: AppColors.appWhite,
      inverseSurface: AppColors.appGrey,

      shadow: AppColors.appBlack,
    ),
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.appGrey,
    textTheme: TextTheme(
      displayLarge: GoogleFonts.outfit(fontSize: 57, fontWeight: FontWeight.normal),
      displayMedium: GoogleFonts.outfit(fontSize: 45, fontWeight: FontWeight.normal),
      displaySmall: GoogleFonts.outfit(fontSize: 44, fontWeight: FontWeight.normal),
      headlineLarge: GoogleFonts.outfit(fontSize: 36, fontWeight: FontWeight.normal),
      headlineMedium: GoogleFonts.outfit(fontSize: 32, fontWeight: FontWeight.normal),
      headlineSmall: GoogleFonts.outfit(fontSize: 28, fontWeight: FontWeight.normal),
      titleLarge: GoogleFonts.outfit(fontSize: 22, fontWeight: FontWeight.bold),
      titleMedium: GoogleFonts.outfit(fontSize: 16, fontWeight: FontWeight.bold),
      titleSmall: GoogleFonts.outfit(fontSize: 14, fontWeight: FontWeight.bold),
      bodyLarge: GoogleFonts.quicksand(fontSize: 16, fontWeight: FontWeight.normal),
      bodyMedium: GoogleFonts.quicksand(fontSize: 14, fontWeight: FontWeight.normal),
      bodySmall: GoogleFonts.quicksand(fontSize: 12, fontWeight: FontWeight.normal),
    ).apply(
      bodyColor: AppTheme.appBlack,
      displayColor: AppTheme.appBlack,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: AppColors.appOrange,
        foregroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ),
  );

  static final dark = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.dark,
      seedColor: const Color(0xFF2E2E2E),
      primary: const Color(0xFFA8D0E6),
      secondary: const Color(0xFFdca738),
      surface: AppTheme.appBlack,
      inverseSurface: const Color(0xFFFFFFFF),
      onPrimary: const Color(0xFFFFFFFF),
    ),
    useMaterial3: true,
    textTheme: TextTheme(
      displayLarge: GoogleFonts.quicksand(fontSize: 57, fontWeight: FontWeight.normal),
      displayMedium: GoogleFonts.quicksand(fontSize: 45, fontWeight: FontWeight.normal),
      displaySmall: GoogleFonts.quicksand(fontSize: 44, fontWeight: FontWeight.normal),
      headlineLarge: GoogleFonts.quicksand(fontSize: 36, fontWeight: FontWeight.normal),
      headlineMedium: GoogleFonts.quicksand(fontSize: 32, fontWeight: FontWeight.normal),
      headlineSmall: GoogleFonts.quicksand(fontSize: 28, fontWeight: FontWeight.normal),
      titleLarge: GoogleFonts.quicksand(fontSize: 22, fontWeight: FontWeight.bold),
      titleMedium: GoogleFonts.quicksand(fontSize: 16, fontWeight: FontWeight.bold),
      titleSmall: GoogleFonts.quicksand(fontSize: 14, fontWeight: FontWeight.bold),
      bodyLarge: GoogleFonts.raleway(fontSize: 16, fontWeight: FontWeight.normal),
      bodyMedium: GoogleFonts.raleway(fontSize: 14, fontWeight: FontWeight.normal),
      bodySmall: GoogleFonts.raleway(fontSize: 12, fontWeight: FontWeight.normal),
    ).apply(
      bodyColor: AppTheme.appWhite,
      displayColor: AppTheme.appWhite,
    ),
    chipTheme: ChipThemeData(
        backgroundColor: AppTheme.appBlack,
        selectedColor: const Color(0xFF71a785),
        secondarySelectedColor: const Color(0xFF71a785),
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: Color(0xFF71a785), width: 2),
        )
    ),
  );
}