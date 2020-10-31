import 'package:auth/app.dart';
import 'package:auth/utils/utils.dart';
import 'package:auth/widgets/BaseScroll.dart';
import 'package:auth/widgets/CommonAppbar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfigPage extends StatefulWidget {
  @override
  _ConfigPageState createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> {
  SharedPreferences prefs;

  bool _currentTheme = false;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () => initPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppbar(showLanguage: true),
      body: BaseScroll(
        children: [
          SwitchListTile(
            value: _currentTheme,
            onChanged: (bool value) => updateTheme(value),
            title: Text("Dark Theme", style: textStyle),
          )
        ],
      ),
    );
  }

  void initPage() async {
    prefs = await SharedPreferences.getInstance();

    _currentTheme = prefs.getBool(ThemeSaved);
    setState(() {});
  }

  void updateTheme(bool value) {
    setState(() {
      _currentTheme = value;
      MyApp.setTheme(context, _currentTheme ? ThemeMode.dark : ThemeMode.light);
    });
  }
}
