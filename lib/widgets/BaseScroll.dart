import 'package:flutter/material.dart';

class BaseScroll extends StatefulWidget {
  final List<Widget> children;
  final Color backgroundColor;
  final bool safeArea;

  BaseScroll(
      {@required this.children,
      this.backgroundColor = Colors.white,
      this.safeArea = false});

  @override
  _BaseScrollState createState() => _BaseScrollState();
}

class _BaseScrollState extends State<BaseScroll> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.backgroundColor,
      width: double.infinity,
      height: double.infinity,
      alignment: Alignment.center,
      child: SafeArea(
        left: widget.safeArea,
        top: widget.safeArea,
        right: widget.safeArea,
        bottom: widget.safeArea,
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              padding: const EdgeInsets.fromLTRB(12, 40, 12, 40),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: widget.children,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
