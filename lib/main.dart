import 'package:auth/app.dart';
import 'package:auth/provider/Theme/AppThemeProvider.dart';
import 'package:auth/provider/User/UserProvider.dart';
import 'package:auth/routes/routes.dart';
import 'package:auth/services/Auth/Auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  // Create routes
  Routes.createRoutes();

  // Initialize firebase configs
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    ChangeNotifierProvider<AppThemeProvider>(
      create: (context) => AppThemeProvider(),
      child: MultiProvider(
        providers: [
          StreamProvider<User>.value(value: Auth().authStateChanges()),
          ChangeNotifierProvider(create: (_) => UserProvider()),
        ],
        child: MyApp(),
      ),
    ),
  );
}
