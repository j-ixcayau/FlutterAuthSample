import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class AppThemeProvider with ChangeNotifier {
  AppThemeProvider() {
    var brightness = SchedulerBinding.instance.window.platformBrightness;
    final isDarknes = brightness == Brightness.dark;

    _mode = (isDarknes) ? ThemeMode.dark : ThemeMode.light;
  }

  ThemeMode _mode = ThemeMode.system;

  ThemeMode get getCurrentMode => _mode;
  set setCurrentMode(ThemeMode mode) {
    _mode = mode;
    notifyListeners();
  }
}
