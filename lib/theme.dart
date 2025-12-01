import 'package:flutter/material.dart';

class AppTheme {
  static const Color orange = Color(0xFFFF7A00);
  static const Color yellow = Color(0xFFFFC107);
  static const Color white = Color(0xFFFFFFFF);
  static const Color background = Color(0xFFFFF6EE);
  static const Color textColor = Color(0xFF4A4A4A);
  static const Color placeholder = Color(0xFFC8C8C8);
  static const Color cardBackground = Color(0xFFFFFFFF);
  static const Color cardBorder = Color(0xFFF1E6DD);

  static ThemeData theme = ThemeData(
    scaffoldBackgroundColor: background,
    fontFamily: 'Poppins',
    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: textColor, fontSize: 16),
    ),
    colorScheme: const ColorScheme.light(
      primary: orange,
      secondary: orange,
    ),
  );
}