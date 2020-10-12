import 'package:auth/utils/utils.dart';
import 'package:flutter/material.dart';

class CommonAppbar extends StatefulWidget implements PreferredSizeWidget {
  @override
  _CommonAppbarState createState() => _CommonAppbarState();

  @override
  Size get preferredSize => new Size.fromHeight(kToolbarHeight);
}

class _CommonAppbarState extends State<CommonAppbar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: primaryColor,
      title: Text("Samples"),
      centerTitle: true,
    );
  }
}
