import 'package:auth/localization/configLocalization.dart';
import 'package:auth/provider/AppThemeProvider.dart';
import 'package:auth/routes/routeNames.dart';
import 'package:auth/routes/routes.dart';
import 'package:auth/theme.dart';
import 'package:auth/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sailor/sailor.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyApp extends StatefulWidget {
  // Config for locale
  static void setLocale(BuildContext context, Locale locale) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>();
    state.setLocate(locale);
  }

  // Config for theme
  static void setTheme(BuildContext context, ThemeMode mode) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>();
    state.updateTheme(mode);
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  SharedPreferences prefs;

  Locale _locale = Locale(EnglishLocale);
  AppThemeProvider _themeProvider = AppThemeProvider();

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () => initConfigs());
  }

  @override
  Widget build(BuildContext context) {
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
      themeMode: _themeProvider.getCurrentMode,
      navigatorKey: Routes.sailor.navigatorKey,
      onGenerateRoute: Routes.sailor.generator(),
      initialRoute: initialRoute,
      navigatorObservers: [
        SailorLoggingObserver(),
      ],
    );
  }

  void setLocate(Locale locale) {
    _locale = locale;
    setState(() {});
  }

  void initConfigs() async {
    prefs = await SharedPreferences.getInstance();

    configLanguage();
    configTheme();
  }

  void configLanguage() {
    final String localeSaved = prefs.getString(LocationSaved);

    if (localeSaved != null && localeSaved.trim().isNotEmpty)
      setLocate(Locale(localeSaved));
  }

  void configTheme() {
    _themeProvider.addListener(() {
      setState(() {});
    });

    final bool themeSaved = prefs.getBool(ThemeSaved);
    updateTheme(themeSaved ? ThemeMode.dark : ThemeMode.light);
  }

  void updateTheme(ThemeMode mode) {
    _themeProvider.setCurrentMode = mode;

    prefs.setBool(ThemeSaved, mode == ThemeMode.dark);
    if (mode == ThemeMode.light) {
      CustomTheme.setLight();
      prefs.setBool(ThemeSaved, false);
    } else if (mode == ThemeMode.dark) {
      CustomTheme.setDark();
      prefs.setBool(ThemeSaved, true);
    }
    setState(() {});
  }
}
