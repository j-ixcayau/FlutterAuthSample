import 'package:flutter/material.dart';

class CommonText extends StatefulWidget {
  final String text;
  final TextStyle style;

  CommonText(this.text, {this.style});

  @override
  _CommonTextState createState() => _CommonTextState();
}

class _CommonTextState extends State<CommonText> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        widget.text ?? "",
        style: widget.style ?? Theme.of(context).textTheme.bodyText1,
        textAlign: TextAlign.center,
      ),
    );
  }
}
