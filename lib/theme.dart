import 'package:flutter/material.dart';
import 'package:auth/utils/utils.dart';

class CustomTheme {
  static getTheme() {
    return ThemeData(
      primarySwatch: Colors.blue,
      primaryColor: primaryColor,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }
}
