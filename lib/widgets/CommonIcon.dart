import 'package:auth/utils/Colors.dart';
import 'package:flutter/material.dart';

class CommonIcon extends StatefulWidget {
  final IconData icon;
  final bool isWhite;
  final Color customColor;
  final double size;

  CommonIcon(this.icon, {this.customColor, this.isWhite = false, this.size});

  @override
  _CommonIconState createState() => _CommonIconState();
}

class _CommonIconState extends State<CommonIcon> {
  @override
  Widget build(BuildContext context) {
    return Icon(
      widget.icon,
      color: (widget.customColor != null)
          ? widget.customColor
          : (widget.isWhite)
              ? whiteColor
              : Theme.of(context).primaryColor,
      size: widget.size,
    );
  }
}
