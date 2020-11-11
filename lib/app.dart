import 'package:auth/localization/configLocalization.dart';
import 'package:auth/provider/Theme/AppThemeProvider.dart';
import 'package:auth/routes/routeNames.dart';
import 'package:auth/routes/routes.dart';
import 'package:auth/theme.dart';
import 'package:auth/utils/themeCodes.dart';
import 'package:auth/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyApp extends StatefulWidget {
  static void setLocale(BuildContext context, Locale locale) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>();
    state.setLocate(locale);
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  SharedPreferences _prefs;

  Locale _locale = Locale(EnglishLocale);
  AppThemeProvider _themeProvider;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () => initConfigs());
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppThemeProvider>(
      builder: (context, _appProvider, child) {
        _themeProvider = _appProvider;

        return MaterialApp(
          title: 'Auth Sample',
          debugShowCheckedModeBanner: false,
          locale: _locale,
          supportedLocales: [
            Locale(EnglishLocale),
            Locale(SpanishLocale),
          ],
          localizationsDelegates: [
            ConfigLocalization.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          localeResolutionCallback: (deviceLocale, supportedLocales) {
            for (var locale in supportedLocales) {
              if (locale.languageCode == deviceLocale.languageCode &&
                  locale.countryCode == deviceLocale.countryCode) {
                return deviceLocale;
              }
            }
            return supportedLocales.first;
          },
          theme: CustomTheme.getLigth(),
          darkTheme: CustomTheme.getDark(),
          themeMode: _themeProvider.getCurrentMode ?? ThemeMode.system,
          navigatorKey: Routes.sailor.navigatorKey,
          onGenerateRoute: Routes.sailor.generator(),
          initialRoute: initialRoute,
          navigatorObservers: [
            // SailorLoggingObserver(),
          ],
        );
      },
    );
  }

  void setLocate(Locale locale) {
    _locale = locale;
    setState(() {});
  }

  void initConfigs() async {
    _prefs = await SharedPreferences.getInstance();

    configLanguage();
    configTheme();
  }

  void configLanguage() {
    final String localeSaved = _prefs.getString(LocationSaved);

    if (localeSaved != null && localeSaved.trim().isNotEmpty)
      setLocate(Locale(localeSaved));
    else
      Future.delayed(Duration(seconds: 1),
          () => _prefs.setString(LocationSaved, _locale.languageCode));
  }

  void configTheme() {
    final String themeSaved = _prefs.getString(ThemeSaved);

    _themeProvider.setCurrentMode = _themeProvider.getThemeMode(themeSaved);
    // setState(() {});
  }
}
