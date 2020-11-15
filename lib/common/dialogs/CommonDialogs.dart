import 'package:auth/localization/Internationalization.dart';
import 'package:auth/utils/Utils.dart';
import 'package:flutter/material.dart';

commonOkDialog(BuildContext context, String msg,
    {bool cancel = true, Function function}) {
  showDialog(
    context: context,
    barrierDismissible: cancel,
    builder: (BuildContext ct) {
      return AlertDialog(
        content: Text(
          msg,
          textAlign: TextAlign.center,
          // style: Theme.of(context).textTheme.bodyText2,
        ),
        actions: [
          (!cancel && function != null)
              ? FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    Internationalization(context).getString(cancelKey),
                    // style: Theme.of(context).textTheme.bodyText2,
                  ),
                )
              : SizedBox(),
          FlatButton(
            onPressed: () {
              Navigator.pop(context);
              if (function != null) function();
            },
            child: Text(
              Internationalization(context).getString(acceptKey),
              // style: Theme.of(context).textTheme.bodyText2,
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
        // style: textLigthStyle,
      ),
      content: Text(
        _int.getString(exitAppKey),
        // style: textLigthStyle,
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(
            _int.getString(cancelKey),
            // style: textLigthStyle,
          ),
        ),
        FlatButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(
            _int.getString(continueKey),
            // style: textLigthStyle,
          ),
        ),
      ],
    ),
  );
}
