import 'package:auth/utils/colors.dart';
import 'package:flutter/material.dart';

class CommonIcon extends StatefulWidget {
  final IconData icon;
  final bool isWhite;

  CommonIcon(this.icon, {this.isWhite = false});

  @override
  _CommonIconState createState() => _CommonIconState();
}

class _CommonIconState extends State<CommonIcon> {
  @override
  Widget build(BuildContext context) {
    return Icon(
      widget.icon,
      color: (widget.isWhite) ? whiteColor : Theme.of(context).primaryColor,
    );
  }
}
