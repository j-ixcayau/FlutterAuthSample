import 'package:auth/routes.dart';
import 'package:auth/theme.dart';
import 'package:auth/services/Auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
        theme: CustomTheme.getTheme(),
        routes: Routes.routes(),
        initialRoute: "/",
      ),
    );
  }
}
