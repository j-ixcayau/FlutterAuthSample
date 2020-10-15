import 'package:auth/utils/colors.dart';
import 'package:flutter/material.dart';

class ProgressDialog {
  BuildContext baseContext;
  bool state = false;

  ProgressDialog(BuildContext ctx) {
    baseContext = ctx;
  }

  show() {
    state = true;
    showDialog(
      context: baseContext,
      barrierDismissible: false,
      builder: (_) {
        return AlertDialog(
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
                    valueColor: new AlwaysStoppedAnimation<Color>(primaryColor),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  hide() {
    if (state) {
      state = false;
      Navigator.pop(baseContext);
    }
  }

  bool isShowing() {
    return state;
  }
}
