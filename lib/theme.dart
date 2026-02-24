import 'package:flutter/material.dart';

// Color palette
const Color kButtonColor = Color(0xFF2C3E50); // button color
const Color kTitleTextColor = Color(0xFF0F1724); // Text Title color
const Color kComponentBackground = Color(0xFFE9ECEF); // component background
const Color kBackground = Color(0xFFFBFAF8); // app background
const Color kGraySubTitle = Color(0xFF6B7280); // gray (sub title)

final ThemeData appTheme = ThemeData(
  useMaterial3: true,
  scaffoldBackgroundColor: kBackground,
  cardColor: kComponentBackground,
  primaryColor: kButtonColor,
  colorScheme: ColorScheme.fromSeed(
    seedColor: kButtonColor,
    primary: kButtonColor,
    background: kBackground,
    surface: kComponentBackground,
    onPrimary: Colors.white,
    onBackground: kTitleTextColor,
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: kButtonColor,
    foregroundColor: Colors.white,
    elevation: 0,
    titleTextStyle: TextStyle(
      color: kTitleTextColor,
      fontSize: 20,
      fontWeight: FontWeight.w600,
    ),
  ),
  textTheme: TextTheme(
    bodyLarge: TextStyle(color: kTitleTextColor),
    bodyMedium: TextStyle(color: kTitleTextColor),
    headlineMedium: TextStyle(
      color: kTitleTextColor,
      fontWeight: FontWeight.w600,
    ),
    titleLarge: TextStyle(color: kTitleTextColor, fontWeight: FontWeight.w700),
    titleMedium: TextStyle(color: kGraySubTitle),
    labelLarge: TextStyle(color: kGraySubTitle),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: kButtonColor,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: kButtonColor,
    foregroundColor: Colors.white,
  ),
  cardTheme: CardThemeData(
    color: kComponentBackground,
    elevation: 0,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  ),
);
