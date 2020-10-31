import 'package:auth/localization/internationalization.dart';
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
              style: textStyle,
            ),
          )
        ],
      );
    },
  );
}

Future<bool> showExitApp(BuildContext context) async {
  Internationalization _int = Internationalization(context);

  return await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(
        _int.getString(areYouSureKey),
        style: textStyle,
      ),
      content: Text(
        _int.getString(exitAppKey),
        style: textStyle,
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(
            _int.getString(cancelKey),
            style: textStyle,
          ),
        ),
        FlatButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(
            _int.getString(continueKey),
            style: textStyle,
          ),
        ),
      ],
    ),
  );
}
