import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/material.dart';
import 'package:universal_platform/universal_platform.dart';

import 'src/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (UniversalPlatform.isLinux ||
      UniversalPlatform.isMacOS ||
      UniversalPlatform.isWindows) {
    await DesktopWindow.setMinWindowSize(const Size(600, 800));
  }

  runApp(const FitnessApp());
}
