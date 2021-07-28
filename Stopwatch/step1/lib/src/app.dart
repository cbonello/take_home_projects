import 'package:flutter/material.dart';

import 'stopwatch/stopwatch.dart';
import 'theme.dart';

class FitnessApp extends StatelessWidget {
  const FitnessApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stopwatch',
      theme: StopwatchTheme.theme(),
      debugShowCheckedModeBanner: false,
      home: const StopwatchPage(),
    );
  }
}
