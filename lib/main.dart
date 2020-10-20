import 'package:auth/localization/demoLocalization.dart';
import 'package:auth/routes.dart';
import 'package:auth/theme.dart';
import 'package:auth/services/Auth.dart';
import 'package:auth/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  static void setLocale(BuildContext context, Locale locale) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>();
    state.setLocate(locale);
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale = Locale(EnglishLocale);

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      String localeSaved = prefs.getString(LocationSaved);

      if (localeSaved != null && localeSaved.trim().isNotEmpty)
        setLocate(Locale(localeSaved));
    });
  }

  void setLocate(Locale locale) {
    _locale = locale;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Auth _auth = Auth();

    return MultiProvider(
      providers: [
        StreamProvider<User>.value(value: _auth.authStateChanges()),
      ],
      child: MaterialApp(
        title: 'Auth Sample',
        debugShowCheckedModeBanner: false,
        locale: _locale,
        supportedLocales: [
          Locale(EnglishLocale),
          Locale(SpanishLocale),
        ],
        localizationsDelegates: [
          DemoLocalization.delegate,
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
        theme: CustomTheme.getTheme(),
        routes: Routes.routes(),
        initialRoute: initialRoute,
      ),
    );
  }
}
