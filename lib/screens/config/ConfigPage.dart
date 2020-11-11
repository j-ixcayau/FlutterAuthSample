import 'package:auth/localization/internationalization.dart';
import 'package:auth/provider/Theme/AppThemeProvider.dart';
import 'package:auth/utils/localeCodes.dart';
import 'package:auth/utils/themeCodes.dart';
import 'package:auth/widgets/BaseScroll.dart';
import 'package:auth/widgets/CommonAppbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfigPage extends StatefulWidget {
  @override
  _ConfigPageState createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> {
  Internationalization _int;
  AppThemeProvider _themeProvider;

  SharedPreferences _prefs;

  ThemeMode _themeMode = ThemeMode.system;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () => initPage());
  }

  @override
  Widget build(BuildContext context) {
    _int = Internationalization(context);
    _themeProvider = Provider.of<AppThemeProvider>(context);

    return Scaffold(
      appBar: CommonAppbar(showLanguage: true),
      body: BaseScroll(
        children: [
          RadioListTile<ThemeMode>(
            title: Text(
              _int.getString(darkThemeKey),
              style: Theme.of(context).textTheme.bodyText1,
            ),
            value: ThemeMode.dark,
            groupValue: _themeMode,
            onChanged: updateTheme,
          ),
          RadioListTile<ThemeMode>(
            title: Text(
              _int.getString(ligthThemeKey),
              style: Theme.of(context).textTheme.bodyText1,
            ),
            value: ThemeMode.light,
            groupValue: _themeMode,
            onChanged: updateTheme,
          ),
          RadioListTile<ThemeMode>(
            title: Text(
              _int.getString(systemThemeKey),
              style: Theme.of(context).textTheme.bodyText1,
            ),
            value: ThemeMode.system,
            groupValue: _themeMode,
            onChanged: updateTheme,
          ),
        ],
      ),
    );
  }

  void initPage() async {
    _prefs = await SharedPreferences.getInstance();

    final String mode = _prefs.getString(ThemeSaved);

    _themeMode = _themeProvider.getThemeMode(mode);
    setState(() {});
  }

  void updateTheme(ThemeMode value) {
    _themeMode = value;
    _prefs.setString(ThemeSaved, _themeProvider.getThemeStr(value));

    _themeProvider.setCurrentMode = _themeMode;

    setState(() {});
  }
}
