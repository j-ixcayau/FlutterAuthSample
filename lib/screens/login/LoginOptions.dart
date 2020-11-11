import 'package:auth/common/dialogs/commonsDialogs.dart';
import 'package:auth/enums/AuthType.dart';
import 'package:auth/localization/internationalization.dart';
import 'package:auth/provider/User/UserProvider.dart';
import 'package:auth/routes/routeNames.dart';
import 'package:auth/services/Auth/Auth.dart';
import 'package:auth/utils/utils.dart';
import 'package:auth/widgets/BaseScroll.dart';
import 'package:auth/widgets/CommonButton.dart';
import 'package:auth/widgets/CommonIcon.dart';
import 'package:auth/widgets/CommonInput.dart';
import 'package:auth/widgets/OnCloseApp.dart';
import 'package:auth/widgets/SocialButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:auth/model/user/user.dart' as usr;

class LoginOptions extends StatefulWidget {
  @override
  _LoginOptionsState createState() => _LoginOptionsState();
}

class _LoginOptionsState extends State<LoginOptions> {
  ProgressDialog _pr;
  Internationalization _int;

  // Provider
  UserProvider _userProvider;

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

    _userProvider = Provider.of<UserProvider>(context);

    return OnCloseApp(
      child: Scaffold(
        body: BaseScroll(
          safeArea: false,
          backgroundColor: Theme.of(context).primaryColor,
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
                    controller: _userController,
                    prefixIcon: CommonIcon(Icons.person, isWhite: true),
                    hint: _int.getString(emailKey),
                    isDark: true,
                  ),
                  SizedBox(height: 10),
                  CommonInput(
                    controller: _passwordController,
                    hint: _int.getString(passwordKey),
                    obscureText: true,
                    prefixIcon: CommonIcon(Icons.lock, isWhite: true),
                    isDark: true,
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
              callback: null,
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
            SizedBox(height: 10),
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

      if (userCredential != null) getUserInfo(userCredential);
    } on FirebaseAuthException catch (e) {
      _pr.hide();

      print("AUTH ERROR ----- AUTH ERROR");
      print(e);
      showUserError(e.code);
    }
  }

  void getUserInfo(UserCredential credential) async {
    final usr.User user = await _userProvider
        .requestUser(credential.user.uid)
        .catchError((error) {
      print(error);
    });

    if (user != null) {
      _userProvider.setUser = user;
      navigateToDashboard();
    } else {
      registerUser(credential);
    }
  }

  void registerUser(UserCredential credential) async {
    usr.User user = usr.User(
      id: credential.user.uid,
      name: credential.user.displayName,
      email: credential.user.email,
      profilePicture: credential.user.photoURL,
    );

    await _userProvider.createUser(user).then((value) async {
      user = await _userProvider.requestUser(credential.user.uid);
      _userProvider.setUser = user;

      navigateToDashboard();
    }).catchError((error) {
      _pr.hide();
      commonOkDialog(context, error);
    });
  }

  void navigateToDashboard() {
    _pr.hide();
    navigateToPage(dashboardRoute, back: false);
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
    commonOkDialog(context, error);
  }
}
