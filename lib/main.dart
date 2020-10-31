import 'package:auth/app.dart';
import 'package:auth/routes/routes.dart';
import 'package:auth/services/Auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  Routes.createRoutes();

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  Auth _auth = Auth();

  runApp(
    MultiProvider(
      providers: [
        StreamProvider<User>.value(value: _auth.authStateChanges()),
      ],
      child: MyApp(),
    ),
  );
}
