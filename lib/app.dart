import 'package:auth/localization/ConfigLocalization.dart';
import 'package:auth/provider/Theme/AppThemeProvider.dart';
import 'package:auth/routes/RouteNames.dart';
import 'package:auth/routes/Routes.dart';
import 'package:auth/Theme.dart';
import 'package:auth/screens/utils/error/errorPage.dart';
import 'package:auth/utils/ThemeCodes.dart';
import 'package:auth/utils/Utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyApp extends StatefulWidget {
  static void setLocale(BuildContext context, Locale locale) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>();
    state._setLocate(locale);
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

    Future.delayed(Duration.zero, _initConfigs);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppThemeProvider>(
      builder: (context, _appProvider, child) {
        _themeProvider = _appProvider;

        return MaterialApp(
          title: 'Auth Sample',
          debugShowCheckedModeBanner: false,

          /// Locale Config
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

          /// Theme Config
          theme: CustomTheme.getLigth(),
          darkTheme: CustomTheme.getDark(),
          themeMode: _themeProvider.getCurrentMode ?? ThemeMode.light,

          /// Routes Config
          navigatorKey: Routes.sailor.navigatorKey,
          onGenerateRoute: Routes.sailor.generator(),
          initialRoute: initialLoadingRoute,

          builder: (BuildContext context, Widget widget) {
            ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
              return ErrorPage(errorDetails);
            };

            return widget;
          },
        );
      },
    );
  }

  void _setLocate(Locale locale) {
    _locale = locale;
    setState(() {});
  }

  void _initConfigs() async {
    _prefs = await SharedPreferences.getInstance();

    _configLanguage();
    _configTheme();
  }

  void _configLanguage() {
    final String localeSaved = _prefs.getString(LocationSaved);

    if (localeSaved != null && localeSaved.trim().isNotEmpty)
      _setLocate(Locale(localeSaved));
    else
      Future.delayed(Duration(seconds: 1),
          () => _prefs.setString(LocationSaved, _locale.languageCode));
  }

  void _configTheme() {
    final String themeSaved = _prefs.getString(ThemeSaved);

    _themeProvider.setCurrentMode = _themeProvider.getThemeMode(themeSaved);
    // setState(() {});
  }
}
