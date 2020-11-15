import 'package:auth/common/dialogs/CommonDialogs.dart';
import 'package:auth/common/progressDialog/ProgressDialog.dart';
import 'package:auth/localization/Internationalization.dart';
import 'package:auth/provider/User/UserProvider.dart';
import 'package:auth/routes/RouteNames.dart';
import 'package:auth/services/auth/AuthService.dart';
import 'package:auth/utils/Utils.dart';
import 'package:auth/widgets/BaseScroll.dart';
import 'package:auth/widgets/CommonButton.dart';
import 'package:auth/widgets/CommonIcon.dart';
import 'package:auth/widgets/CommonInput.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:auth/model/user/User.dart' as usr;
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  Internationalization _int;
  ProgressDialog _pr;

  // Provider
  UserProvider _userProvider;

  AuthService _auth = AuthService();

  TextEditingController _userController;
  TextEditingController _passwordController;

  final _formKey = GlobalKey<FormState>();

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void initState() {
    super.initState();

    _userController = TextEditingController(text: "");
    _passwordController = TextEditingController(text: "");

    Future.delayed(Duration.zero, _initPage);
  }

  @override
  Widget build(BuildContext context) {
    _int = Internationalization(context);

    _userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
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
                  prefixIcon: CommonIcon(Icons.person, isWhite: true),
                  controller: _userController,
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
            callback: _validateForm,
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  void _initPage() {
    _pr = ProgressDialog(context);
  }

  void _validateForm() async {
    if (_formKey.currentState.validate()) {
      try {
        _pr.show();

        final String email = _userController.text.trim();
        final String password = _passwordController.text.trim();

        final UserCredential userCredential =
            await _auth.createUserWithEmailAndPassword(email, password);

        if (userCredential != null)
          _registerUser(userCredential);
        else
          _pr.hide();
      } on FirebaseAuthException catch (e) {
        _pr.hide();
        _showUserError(e.code);
      }
    }
  }

  void _registerUser(UserCredential credential) async {
    usr.User user = usr.User(
      id: credential.user.uid,
      name: credential.user.displayName,
      email: credential.user.email,
      profilePicture: credential.user.photoURL,
    );

    await _userProvider.createUser(user).then((value) async {
      user = await _userProvider.requestUser(credential.user.uid);
      _userProvider.setUser = user;

      _navigateToDashboard();
    }).catchError((error) {
      _pr.hide();
      commonOkDialog(context, error.toString());
    });
  }

  void _navigateToDashboard() {
    _pr.hide();
    navigateToPage(dashboardRoute, back: false);
  }

  void _showUserError(String err) {
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
