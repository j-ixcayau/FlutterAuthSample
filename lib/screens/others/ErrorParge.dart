import 'package:flutter/material.dart';

class ErrorPage extends StatefulWidget {
  @override
  _ErrorPageState createState() => _ErrorPageState();
}

class _ErrorPageState extends State<ErrorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: Text("Ha ocurrido un error\nPor favor intentalo de nuevo"),
        ),
      ),
    );
  }
}
