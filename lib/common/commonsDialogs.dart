import 'package:auth/localization/internationalization.dart';
import 'package:auth/utils/colors.dart';
import 'package:auth/utils/utils.dart';
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
              Internationalization(context).getString(acceptKey),
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
