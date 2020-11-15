import 'dart:ui';

import 'package:auth/app.dart';
import 'package:auth/localization/Internationalization.dart';
import 'package:auth/utils/Utils.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangeLocaleIcon extends StatefulWidget {
  @override
  _ChangeLocaleIconState createState() => _ChangeLocaleIconState();
}

class _ChangeLocaleIconState extends State<ChangeLocaleIcon> {
  SharedPreferences _prefs;
  Internationalization _int;

  List<String> languages = [EnglishLocale, SpanishLocale];
  String currentLanguage;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, initWidet);
  }

  @override
  Widget build(BuildContext context) {
    _int = Internationalization(context);

    return PopupMenuButton(
      itemBuilder: (context) {
        var list = List<PopupMenuEntry<String>>();
        list.add(
          PopupMenuItem(
            child: Text(
              _int.getString(settingLanguageKey),
            ),
            value: null,
          ),
        );
        list.add(
          PopupMenuDivider(
            height: 10,
          ),
        );
        list.add(
          CheckedPopupMenuItem(
            child: Text(
              _int.getString(englishKey),
            ),
            value: EnglishLocale,
            checked: currentLanguage == EnglishLocale,
          ),
        );
        list.add(
          CheckedPopupMenuItem(
            child: Text(
              _int.getString(spanishKey),
            ),
            value: SpanishLocale,
            checked: currentLanguage == SpanishLocale,
          ),
        );
        return list;
      },
      icon: Icon(
        Icons.language,
        color: Colors.white,
      ),
      onSelected: _updateLanguage,
    );
  }

  void initWidet() async {
    _prefs = await SharedPreferences.getInstance();

    currentLanguage = _prefs.getString(LocationSaved);
    setState(() {});
  }

  void _updateLanguage(String locale) {
    currentLanguage = locale;

    Locale newLocale = Locale(locale);

    _saveLocale();

    MyApp.setLocale(context, newLocale);
    setState(() {});
  }

  void _saveLocale() async {
    _prefs.setString(LocationSaved, currentLanguage);
  }
}
