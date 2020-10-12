import 'package:auth/services/Auth.dart';
import 'package:auth/utils/colors.dart';
import 'package:auth/widgets/BaseScroll.dart';
import 'package:auth/widgets/CommonAppbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  Auth _auth = Auth();
  User user;

  @override
  Widget build(BuildContext context) {
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
            (user == null) ? "No user Logged" : user.email,
          ),
          FlatButton(
            onPressed: () => signOut(),
            child: Text("SignOut"),
          ),
        ],
      ),
    );
  }

  signOut() async {
    _auth.signOut().then((value) {
      Navigator.pushNamedAndRemoveUntil(
          context, "/loginOptions", (Route<dynamic> route) => false);
    });
  }
}
