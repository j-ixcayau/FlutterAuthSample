import 'package:flutter/material.dart';

/// Class only have been to be created
/// only one time per page to avoid presistent dialog
/// when use setState(() {});
class ProgressDialog {
  BuildContext baseContext;
  bool state = false;

  ProgressDialog(BuildContext context) {
    baseContext = context;
  }

  show() {
    state = true;
    showDialog(
      context: baseContext,
      barrierDismissible: false,
      builder: (_) {
        /// WillPopScope is used to avoid close
        /// dialog on back

        return WillPopScope(
          child: AlertDialog(
            backgroundColor: Colors.transparent,
            content: Builder(
              builder: (context) {
                return Container(
                  height: 75,
                  width: 75,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.white,
                  ),
                  child: Center(
                    child: CircularProgressIndicator(
                      valueColor: new AlwaysStoppedAnimation<Color>(
                          Theme.of(baseContext).primaryColor),
                    ),
                  ),
                );
              },
            ),
          ),
          onWillPop: () => false as Future<bool>,
        );
      },
    ).then((value) {
      state = false;
    });
  }

  hide() {
    if (state) {
      Navigator.pop(baseContext);
    }
  }

  bool isShowing() {
    return state;
  }
}
