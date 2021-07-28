import 'package:flutter/material.dart';

class StopwatchTheme {
  static const Color darkPurple = Color(0xFF1A1F39);
  static const Color lightPurple = Color(0xFF2D314F);
  static const Color yellow = Color(0xFFFFE500);

  static ThemeData theme() {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: yellow,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) => yellow,
          ),
          foregroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) => Colors.black,
          ),
        ),
      ),
      scaffoldBackgroundColor: darkPurple,
      iconTheme: const IconThemeData(
        color: yellow,
      ),
      textTheme: const TextTheme(
        headline6: TextStyle(
          fontSize: 36.0,
          fontWeight: FontWeight.bold,
          color: yellow,
        ),
        subtitle2: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
          color: yellow,
        ),
        bodyText2: TextStyle(fontSize: 14.0),
      ),
    );
  }
}
