import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'stopwatch/stopwatch.dart';
import 'theme.dart';

class FitnessApp extends StatelessWidget {
  const FitnessApp({
    Key? key,
    required this.sharedPreferences,
  }) : super(key: key);

  final SharedPreferences sharedPreferences;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stopwatch',
      theme: StopwatchTheme.theme(),
      debugShowCheckedModeBanner: false,
      home: StopwatchPage(sharedPreferences: sharedPreferences),
    );
  }
}
