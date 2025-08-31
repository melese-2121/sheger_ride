import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color kNavyBlue = Color(0xFF0D47A1);
const Color kAmber = Color(0xFFFFC107);
const Color kGrey = Color(0xFF757575);
const Color kDarkNavy = Color(0xFF0D1B2A);
const Color kSurfaceNavy = Color(0xFF1B263B);
const Color kNeonGreen = Color(0xFF00FFB0);

ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.light(
    primary: kNavyBlue,
    secondary: kAmber,
    background: Colors.white,
    surface: Colors.white,
    onPrimary: Colors.white,
    onSecondary: Colors.black,
    onBackground: Colors.black,
    onSurface: Colors.black,
  ),
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(
    backgroundColor: kNavyBlue,
    foregroundColor: Colors.white,
    elevation: 0,
    titleTextStyle: GoogleFonts.poppins(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 20,
    ),
    iconTheme: const IconThemeData(color: Colors.white),
  ),
  textTheme: GoogleFonts.poppinsTextTheme().copyWith(
    headlineMedium: GoogleFonts.poppins(
      fontSize: 22,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    bodyMedium: GoogleFonts.poppins(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: Colors.black,
    ),
    bodySmall: GoogleFonts.poppins(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: kGrey,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: kNavyBlue,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      textStyle: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 16),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: kNavyBlue,
      textStyle: GoogleFonts.poppins(),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: kNavyBlue,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      textStyle: GoogleFonts.poppins(),
    ),
  ),
);

ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.dark(
    primary: kNavyBlue,
    secondary: kAmber,
    background: kDarkNavy,
    surface: kSurfaceNavy,
    onPrimary: Colors.white,
    onSecondary: Colors.black,
    onBackground: Colors.white,
    onSurface: Colors.white,
  ),
  scaffoldBackgroundColor: kDarkNavy,
  appBarTheme: AppBarTheme(
    backgroundColor: kNavyBlue,
    foregroundColor: Colors.white,
    elevation: 0,
    titleTextStyle: GoogleFonts.poppins(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 20,
    ),
    iconTheme: const IconThemeData(color: Colors.white),
  ),
  textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme).copyWith(
    headlineMedium: GoogleFonts.poppins(
      fontSize: 22,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    bodyMedium: GoogleFonts.poppins(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: Colors.white,
    ),
    bodySmall: GoogleFonts.poppins(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: kGrey,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: kNeonGreen,
      foregroundColor: Colors.black,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      textStyle: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 16),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: kNeonGreen,
      textStyle: GoogleFonts.poppins(),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: kNeonGreen,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      textStyle: GoogleFonts.poppins(),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: kSurfaceNavy,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: kNeonGreen, width: 2),
    ),
    hintStyle: GoogleFonts.poppins(color: kGrey),
    labelStyle: GoogleFonts.poppins(color: Colors.white),
  ),
);
