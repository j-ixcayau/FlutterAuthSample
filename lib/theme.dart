import 'package:auth/utils/Styles.dart';
import 'package:flutter/material.dart';
import 'package:auth/utils/Utils.dart';

class CustomTheme {
  static ThemeData getLigth() {
    return ThemeData(
      scaffoldBackgroundColor: LigthColors.primaryColor,
      brightness: Brightness.light,
      primaryColorBrightness: Brightness.light,
      //
      primarySwatch: LigthColors.primarySwatch,
      primaryColor: LigthColors.primaryColor,
      primaryColorLight: LigthColors.primaryLightColor,
      primaryColorDark: LigthColors.primaryDarkColor,
      accentColor: LigthColors.accentColor,
      textSelectionHandleColor: Colors.white,
      //
      visualDensity: VisualDensity.standard,
      //
      appBarTheme: AppBarTheme(
        color: LigthColors.primaryColor,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      //
      textTheme: TextTheme(
        // Principal title white
        headline1: headlineStyle.copyWith(color: whiteColor),
        // Principal title primary
        headline2: headlineStyle.copyWith(color: LigthColors.primaryColor),
        // Commont text primary
        bodyText1: bodyStyle.copyWith(color: LigthColors.primaryColor),
        // Commont text white
        bodyText2: bodyStyle.copyWith(color: whiteColor),
        //
        button: TextStyle(
          color: Colors.white,
        ),
      ),
      //
      iconTheme: IconThemeData(
        color: LigthColors.primaryColor,
      ),
      //
      unselectedWidgetColor: Colors.black54,
      //
      inputDecorationTheme: InputDecorationTheme(
        fillColor: LigthColors.primaryColor,
        focusColor: LigthColors.primaryColor,
        hoverColor: LigthColors.primaryColor,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: LigthColors.primaryColor),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: LigthColors.primaryColor),
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: LigthColors.primaryColor),
        ),
        disabledBorder: UnderlineInputBorder(
          borderSide:
              BorderSide(color: LigthColors.primaryColor.withOpacity(0.5)),
        ),
      ),
    );
  }

  static ThemeData getDark() {
    return ThemeData(
      scaffoldBackgroundColor: DarkColors.primaryColor,
      brightness: Brightness.dark,
      primaryColorBrightness: Brightness.dark,
      //
      primarySwatch: DarkColors.primarySwatch,
      primaryColor: DarkColors.primaryColor,
      primaryColorLight: DarkColors.primaryLightColor,
      primaryColorDark: DarkColors.primaryDarkColor,
      accentColor: DarkColors.accentColor,
      textSelectionHandleColor: Colors.white,
      //
      visualDensity: VisualDensity.standard,
      //
      appBarTheme: AppBarTheme(
        color: DarkColors.primaryColor,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      //
      textTheme: TextTheme(
        // Principal title white
        headline1: headlineStyle.copyWith(color: whiteColor),
        // Principal title primary
        headline2: headlineStyle.copyWith(color: DarkColors.primaryColor),
        // Commont text primary
        bodyText1: bodyStyle.copyWith(color: DarkColors.primaryColor),
        // Commont text white
        bodyText2: bodyStyle.copyWith(color: whiteColor),
        //
        button: TextStyle(
          color: Colors.white,
        ),
      ),
      //
      iconTheme: IconThemeData(
        color: DarkColors.primaryColor,
      ),
      //
      unselectedWidgetColor: Colors.black54,
      //
      inputDecorationTheme: InputDecorationTheme(
        fillColor: DarkColors.primaryColor,
        focusColor: DarkColors.primaryColor,
        hoverColor: DarkColors.primaryColor,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: DarkColors.primaryColor),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: DarkColors.primaryColor),
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: DarkColors.primaryColor),
        ),
        disabledBorder: UnderlineInputBorder(
          borderSide:
              BorderSide(color: DarkColors.primaryColor.withOpacity(0.5)),
        ),
      ),
    );
  }
}
