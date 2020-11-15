import 'package:auth/routes/RouteNames.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoadingPage extends StatefulWidget {
  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  User _userProvider;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, _initialPage);
  }

  @override
  Widget build(BuildContext context) {
    _userProvider = Provider.of<User>(context);

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  void _initialPage() {
    final User user = _userProvider;

    if (user == null) {
      navigateToPage(loginOptionsRoute, back: false);
    } else {
      navigateToPage(dashboardRoute, back: false);
    }
  }
}
