import 'package:auth/utils/utils.dart';
import 'package:flutter/material.dart';

class CommonInput extends StatefulWidget {
  final TextEditingController controller;
  final String hint;
  final bool obscureText;
  final Widget prefixIcon;
  final bool isEmail;

  CommonInput({
    this.controller,
    this.hint = "",
    this.obscureText = false,
    this.prefixIcon,
    this.isEmail = false,
  });

  @override
  _CommonInputState createState() => _CommonInputState();
}

class _CommonInputState extends State<CommonInput> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 4, 0, 4),
      child: TextFormField(
        controller: widget.controller,
        style: inputStyle,
        obscureText: widget.obscureText,
        decoration: InputDecoration(
          hintText: widget.hint,
          prefixIcon: widget.prefixIcon,
          hintStyle: TextStyle(
            color: Colors.white54,
          ),

          /// Input Borders
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          errorStyle: TextStyle(color: Colors.red),
        ),
        validator: (String text) => validateField(text),
      ),
    );
  }

  validateField(String text) {
    if (text.trim().isEmpty) {
      return "Field can't be empty";
    } else {
      if (widget.isEmail) {
        bool emailValid = RegExp(
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(text);
        if (!emailValid) return "Check your email";
      }
    }
    return null;
  }
}
