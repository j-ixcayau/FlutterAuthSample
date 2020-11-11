import 'package:auth/utils/themeCodes.dart';
import 'package:flutter/material.dart';

class AppThemeProvider with ChangeNotifier {
  ThemeMode _mode;

  ThemeMode get getCurrentMode => _mode;
  set setCurrentMode(ThemeMode mode) {
    this._mode = mode;
    notifyListeners();
  }

  String getThemeStr(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.dark:
        return DarkTheme;
      case ThemeMode.light:
        return LigthTheme;
      default:
        return SystemTheme;
    }
  }

  ThemeMode getThemeMode(String mode) {
    switch (mode) {
      case DarkTheme:
        return ThemeMode.dark;
      case LigthTheme:
        return ThemeMode.light;
      default:
        return ThemeMode.system;
    }
  }
}
