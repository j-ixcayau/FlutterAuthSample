import 'package:auth/common/dialogs/commonsDialogs.dart';
import 'package:flutter/material.dart';

class OnCloseApp extends StatefulWidget {
  final Widget child;

  OnCloseApp({@required this.child});

  @override
  _OnCloseAppState createState() => _OnCloseAppState();
}

class _OnCloseAppState extends State<OnCloseApp> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: widget.child,
    );
  }

  Future<bool> _onWillPop() async {
    return (showExitApp(context)) ?? false;
  }
}
