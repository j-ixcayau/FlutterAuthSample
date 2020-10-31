import 'package:auth/utils/utils.dart';
import 'package:flutter/material.dart';

class CommonButton extends StatefulWidget {
  final Function callback;
  final String text;

  CommonButton({
    @required this.text,
    @required this.callback,
  });

  @override
  CommonButtonState createState() => CommonButtonState();
}

class CommonButtonState extends State<CommonButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 4, 0, 4),
      width: double.infinity,
      child: FlatButton(
        color: accentColor,
        child: Text(
          widget.text,
          style: subtitleStyle,
        ),
        onPressed: widget.callback,
      ),
    );
  }
}
