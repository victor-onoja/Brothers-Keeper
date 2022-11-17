import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData darkTheme = _themeData(_darkColorScheme);

  static _themeData(ColorScheme colorScheme) => ThemeData(
        colorScheme: colorScheme,
        textTheme: GoogleFonts.spaceMonoTextTheme(
          _textTheme(colorScheme),
        ),
      );

  static final ColorScheme _darkColorScheme = const ColorScheme.dark().copyWith(
      primary: AppColors.green.shade500,
      secondary: AppColors.green.shade100,
      onBackground: AppColors.bgcolor.shade400,
      onSurface: AppColors.skyBlue,
      onSecondary: AppColors.green.shade200);

  static TextTheme _textTheme(ColorScheme colorScheme) => TextTheme(
        headline1: TextStyle(
          fontSize: 56,
          fontWeight: FontWeight.bold,
          color: colorScheme.secondary,
        ),
        headline6: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: colorScheme.primary,
        ),
        headline2: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: colorScheme.secondary,
        ),
        headline3: TextStyle(
          fontSize: 42,
          fontWeight: FontWeight.bold,
          color: colorScheme.secondary,
        ),
        headline4: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: colorScheme.onSecondary,
        ),
        headline5: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: colorScheme.primary,
        ),
        subtitle1: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: colorScheme.onBackground,
        ),
      );
}
