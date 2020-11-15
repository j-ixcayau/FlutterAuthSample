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
        color: Theme.of(context).accentColor,
        child: Text(
          widget.text,
          style: Theme.of(context).textTheme.button,
        ),
        onPressed: () => widget.callback(),
      ),
    );
  }
}
