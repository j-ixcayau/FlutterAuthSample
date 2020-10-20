import 'package:auth/localization/internationalization.dart';
import 'package:auth/services/Auth.dart';
import 'package:auth/utils/utils.dart';
import 'package:auth/widgets/BaseScroll.dart';
import 'package:auth/widgets/CommonButton.dart';
import 'package:auth/widgets/CommonInput.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  Auth _auth = Auth();
  Internationalization _int;

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
    _int = Internationalization(context);

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
                  hint: _int.getString(emailKey),
                ),
                SizedBox(height: 10),
                CommonInput(
                  controller: _passwordController,
                  hint: _int.getString(passwordKey),
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
              text: _int.getString(continueKey),
              callback: () => validateForm()),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  validateForm() async {
    if (_formKey.currentState.validate()) {
      try {
        final String email = _userController.text.trim();
        final String password = _passwordController.text.trim();

        final UserCredential userCredential =
            await _auth.createUserWithEmailAndPassword(email, password);
        if (userCredential != null) {
          Navigator.pushNamedAndRemoveUntil(
              context, dashboardRoute, (Route<dynamic> route) => false);
        }
      } on FirebaseAuthException catch (e) {
        showUserError(e.code);
      }
    }
  }

  showUserError(String err) {
    String error = "";

    switch (err) {
      case "user-not-found":
        error = "Usuario no encontrado";
        break;
      default:
    }
    print(error);
  }
}
