import 'package:flutter/material.dart';

const Color _yellow = Color(0xFFFFE500);

class StopwatchTheme {
  static ThemeData theme() {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: _yellow,
      iconTheme: const IconThemeData(
        color: _yellow,
      ),
      textTheme: const TextTheme(
        headline6: TextStyle(
          fontSize: 36.0,
          fontWeight: FontWeight.bold,
          color: _yellow,
        ),
        bodyText2: TextStyle(fontSize: 14.0),
      ),
    );
  }
}
