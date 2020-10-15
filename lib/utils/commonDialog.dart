import 'package:auth/utils/colors.dart';
import 'package:flutter/material.dart';

errorDialog(BuildContext context, String msg) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext ct) {
      return AlertDialog(
        backgroundColor: Colors.white,
        content: Text(
          msg,
          textAlign: TextAlign.center,
        ),
        actions: [
          FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              "Aceptar",
              style: TextStyle(
                color: primaryColor,
              ),
            ),
          )
        ],
      );
    },
  );
}
