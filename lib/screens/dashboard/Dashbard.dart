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
  ProgressDialog pr;

  Auth _auth = Auth();
  User user;

  @override
  Widget build(BuildContext context) {
    pr = ProgressDialog(context);

    user = Provider.of<User>(context);

    return Scaffold(
      appBar: CommonAppbar(),
      body: BaseScroll(
        children: [
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
                ? "${user.displayName}\n${user.email}\n\n${user.uid}"
                : "",
            textAlign: TextAlign.center,
          ),
          CommonButton(
            text: "SignOut",
            callback: () => signOut(),
          ),
        ],
      ),
    );
  }

  signOut() async {
    pr.show();
    _auth.signOut().then((value) {
      pr.hide();

      Navigator.pushNamedAndRemoveUntil(
          context, "/loginOptions", (Route<dynamic> route) => false);
    });
  }
}
