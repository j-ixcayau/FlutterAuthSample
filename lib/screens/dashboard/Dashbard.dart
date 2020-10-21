import 'package:auth/localization/internationalization.dart';
import 'package:auth/services/Auth.dart';
import 'package:auth/utils/colors.dart';
import 'package:auth/utils/utils.dart';
import 'package:auth/widgets/BaseScroll.dart';
import 'package:auth/widgets/CommonAppbar.dart';
import 'package:auth/widgets/CommonButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  ProgressDialog _pr;
  Internationalization _int;

  Auth _auth = Auth();
  User user;

  bool currentLanguage = false;

  @override
  Widget build(BuildContext context) {
    _pr = ProgressDialog(context);
    _int = Internationalization(context);

    user = Provider.of<User>(context);

    return Scaffold(
      appBar: CommonAppbar(showLanguage: true),
      body: BaseScroll(
        children: [
          Text(
            _int.getString(homePageKey),
            style: TextStyle(
              color: primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 28,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 50),
          (user != null && user.photoURL != null)
              ? Image.network(user.photoURL)
              : Icon(
                  Icons.person,
                  color: primaryColor,
                  size: 100,
                ),
          SizedBox(height: 20),
          Text(
            (user != null)
                ? "${user.displayName ?? 'No User Name'}\n${user.email}\n\n${user.uid}"
                : "",
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 40),
          CommonButton(
            text: _int.getString(logoutKey),
            callback: () => signOut(),
          ),
          SizedBox(height: 100),
        ],
      ),
    );
  }

  signOut() async {
    _pr.show();
    await _auth.signOut().then((value) {
      _pr.hide();

      Navigator.pushNamedAndRemoveUntil(
          context, loginOptionsRoute, (Route<dynamic> route) => false);
    });
  }
}
