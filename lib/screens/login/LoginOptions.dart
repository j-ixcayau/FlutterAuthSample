import 'package:auth/services/Auth.dart';
import 'package:auth/utils/colors.dart';
import 'package:auth/utils/utils.dart';
import 'package:auth/widgets/BaseScroll.dart';
import 'package:auth/widgets/CommonButton.dart';
import 'package:auth/widgets/CommonInput.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';

class LoginOptions extends StatefulWidget {
  @override
  _LoginOptionsState createState() => _LoginOptionsState();
}

enum AuthType { email, apple, google, twitter, facebook }

class _LoginOptionsState extends State<LoginOptions> {
  ProgressDialog pr;

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
    pr = ProgressDialog(context);

    return Scaffold(
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
                    color: Colors.white,
                  ),
                  controller: _userController,
                  hint: "Correo",
                ),
                SizedBox(height: 10),
                CommonInput(
                  controller: _passwordController,
                  hint: "Password",
                  obscureText: true,
                  prefixIcon: Icon(
                    Icons.lock,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          CommonButton(
            text: "Continue",
            callback: () => validateForm(),
          ),
          SizedBox(height: 20),
          AppleSignInButton(style: AppleButtonStyle.black),
          GoogleSignInButton(onPressed: () => loginWith(AuthType.google)),
          TwitterSignInButton(),
          FacebookSignInButton(onPressed: () => loginWith(AuthType.facebook)),
          FlatButton(
            onPressed: () => navigateToRegister(),
            child: Text("Register", style: titleStyle),
          ),
        ],
      ),
    );
  }

  navigateToRegister() {
    Navigator.pushNamed(context, "/register");
  }

  validateForm() async {
    if (_formKey.currentState.validate()) {
      loginWith(AuthType.email);
    }
  }

  loginWith(AuthType type) async {
    pr.show();
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

        default:
      }

      pr.hide();
      if (userCredential != null) {
        Navigator.pushNamedAndRemoveUntil(
            context, "/dashboard", (Route<dynamic> route) => false);
      }
    } on FirebaseAuthException catch (e) {
      pr.hide();

      showUserError(e.code);
    }
    pr.hide();
  }

  showUserError(String err) {
    String error = "";

    switch (err) {
      case "user-not-found":
        error = "Usuario no encontrado";
        break;
      default:
        print(err);
    }
    print(error);
  }
}
