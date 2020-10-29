import 'package:auth/app.dart';
import 'package:auth/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangeLocaleIcon extends StatefulWidget {
  @override
  _ChangeLocaleIconState createState() => _ChangeLocaleIconState();
}

class _ChangeLocaleIconState extends State<ChangeLocaleIcon> {
  List<String> languages = [EnglishLocale, SpanishLocale];
  String currentLanguage;

  SharedPreferences prefs;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () async {
      prefs = await SharedPreferences.getInstance();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      child: DropdownButton<String>(
        items: languages.map<DropdownMenuItem<String>>(
          (String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          },
        ).toList(),
        onChanged: (String value) => updateLanguage(value),
        icon: Icon(
          Icons.language,
          color: Colors.white,
        ),
        underline: SizedBox(),
      ),
    );
  }

  updateLanguage(String locale) {
    currentLanguage = locale;

    Locale newLocale = Locale(locale);

    saveLocale();

    MyApp.setLocale(context, newLocale);
    setState(() {});
  }

  saveLocale() async {
    prefs.setString(LocationSaved, currentLanguage);
  }
}
