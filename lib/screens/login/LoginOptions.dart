import 'package:auth/common/dialogs/commonsDialogs.dart';
import 'package:auth/enums/AuthType.dart';
import 'package:auth/localization/internationalization.dart';
import 'package:auth/routes/routeNames.dart';
import 'package:auth/services/Auth.dart';
import 'package:auth/utils/colors.dart';
import 'package:auth/utils/utils.dart';
import 'package:auth/widgets/BaseScroll.dart';
import 'package:auth/widgets/CommonButton.dart';
import 'package:auth/widgets/CommonInput.dart';
import 'package:auth/widgets/OnCloseApp.dart';
import 'package:auth/widgets/SocialButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginOptions extends StatefulWidget {
  @override
  _LoginOptionsState createState() => _LoginOptionsState();
}

class _LoginOptionsState extends State<LoginOptions> {
  ProgressDialog _pr;
  Internationalization _int;

  Auth _auth = Auth();

  TextEditingController _userController;
  TextEditingController _passwordController;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    _userController = TextEditingController(text: "");
    _passwordController = TextEditingController(text: "");
  }

  @override
  Widget build(BuildContext context) {
    _pr = ProgressDialog(context);
    _int = Internationalization(context);

    return OnCloseApp(
      child: Scaffold(
        body: BaseScroll(
          safeArea: false,
          backgroundColor: primaryColor,
          children: [
            Image.asset(
              "assets/logo.png",
              width: 100,
              height: 100,
            ),
            SizedBox(height: 40),
            Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CommonInput(
                    isEmail: true,
                    prefixIcon: Icon(
                      Icons.person,
                      color: textColor,
                    ),
                    controller: _userController,
                    // hint: "Correo",
                    hint: _int.getString(emailKey),
                  ),
                  SizedBox(height: 10),
                  CommonInput(
                    controller: _passwordController,
                    hint: _int.getString(passwordKey),
                    obscureText: true,
                    prefixIcon: Icon(
                      Icons.lock,
                      color: textColor,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            CommonButton(
              text: _int.getString(continueKey),
              callback: () => validateForm(),
            ),
            SocialButton(
              callback: () => loginWith(AuthType.apple),
              type: AuthType.apple,
            ),
            SocialButton(
              callback: () => loginWith(AuthType.google),
              type: AuthType.google,
            ),
            SocialButton(
              callback: () => loginWith(AuthType.twitter),
              type: AuthType.twitter,
            ),
            SocialButton(
              callback: () => loginWith(AuthType.facebook),
              type: AuthType.facebook,
            ),
            SocialButton(
              callback: () => loginWith(AuthType.github),
              type: AuthType.github,
            ),
            CommonButton(
              callback: () => navigateToRegister(),
              text: _int.getString(registerKey),
            ),
            CommonButton(
              callback: () => navigateToPage(configRoute),
              text: _int.getString("Config"),
            ),
          ],
        ),
      ),
    );
  }

  void navigateToRegister() {
    navigateToPage(registerRoute);
  }

  void validateForm() async {
    if (_formKey.currentState.validate()) {
      loginWith(AuthType.email);
    }
  }

  void loginWith(AuthType type) async {
    _pr.show();
    try {
      UserCredential userCredential;

      switch (type) {
        case AuthType.email:
          final String email = _userController.text.trim();
          final String password = _passwordController.text.trim();

          userCredential =
              await _auth.signInWithEmailAndPassword(email, password);
          break;
        case AuthType.facebook:
          userCredential = await _auth.loginFacebook();
          break;
        case AuthType.google:
          userCredential = await _auth.loginGoogle();
          break;
        case AuthType.twitter:
          userCredential = await _auth.loginTwitter();
          break;
        case AuthType.github:
          userCredential = await _auth.loginGithub(context);
          break;
        default:
          break;
      }

      _pr.hide();
      if (userCredential != null) {
        navigateToPage(dashboardRoute, back: false);
      }
    } on FirebaseAuthException catch (e) {
      _pr.hide();

      print("AUTH ERROR ----- AUTH ERROR");
      print(e);
      showUserError(e.code);
    }
    _pr.hide();
  }

  void showUserError(String err) {
    String error = "";

    switch (err) {
      case "user-not-found":
        error = _int.getString(userNotFoundKey);
        break;
      case "account-exists-with-different-credential":
        error = _int.getString(registeredDifferentMethodKey);
        break;
      case "wrong-password":
        error = _int.getString(wrongPasswordKey);
        break;
      default:
        print(err);
    }
    errorDialog(context, error);
  }
}
