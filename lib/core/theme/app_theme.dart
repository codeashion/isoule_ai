import 'package:flutter/material.dart';
import 'package:isoule_ai/core/constants/app_colors.dart';

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
