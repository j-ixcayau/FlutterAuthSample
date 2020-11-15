import 'package:flutter/material.dart';

/// Class only have been to be created
/// only one time per page to avoid presistent dialog
/// when use setState(() {});
class ProgressDialog {
  BuildContext _context;
  bool _state = false;

  ProgressDialog(BuildContext context) {
    _context = context;
  }

  void show() {
    if (!_state) {
      _state = true;
      showDialog(
        context: _context,
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
                            Theme.of(_context).primaryColor),
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
        _state = false;
      });
    }
  }

  void hide() {
    try {
      if (_state) Navigator.of(_context, rootNavigator: true).pop();
    } catch (e) {
      print(e);
    }
  }

  bool isShowing() {
    return _state;
  }
}
