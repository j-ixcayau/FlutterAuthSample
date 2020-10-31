import 'package:flutter/material.dart';
import 'package:auth/utils/utils.dart';

class CustomTheme {
  static getLigth() {
    return ThemeData(
      brightness: Brightness.light,
      primarySwatch: Colors.blue,
      primaryColor: primaryColor,
      accentColor: accentColor,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }

  static getDark() {
    return ThemeData(
      brightness: Brightness.dark,
      primarySwatch: Colors.blue,
      primaryColor: primaryDarkColor,
      accentColor: accentDarkColor,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }

  static setLight() {
    primaryColor = primaryLightColor;
    accentColor = accentLightColor;
    textColor = textLightColor;
    errorColor = errorLigthColor;

    reverseTextcolor = textDarkColor;
    reversePrimaryColor = primaryDarkColor;
  }

  static setDark() {
    primaryColor = primaryDarkColor;
    accentColor = accentDarkColor;
    textColor = textDarkColor;
    errorColor = errorDarkColor;

    reverseTextcolor = textLightColor;
    reversePrimaryColor = primaryLightColor;
  }
}
