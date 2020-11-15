import 'package:auth/localization/Internationalization.dart';
import 'package:auth/utils/Utils.dart';
import 'package:flutter/material.dart';

class CommonInput extends StatefulWidget {
  final TextEditingController controller;
  final String hint;
  final bool obscureText;
  final Widget prefixIcon;
  final bool isEmail;
  final bool isDark;
  final Function onTap;

// IsDark is true required in non white page
  CommonInput({
    this.controller,
    this.hint = "",
    this.obscureText = false,
    this.prefixIcon,
    this.isEmail = false,
    this.isDark = false,
    this.onTap,
  });

  @override
  _CommonInputState createState() => _CommonInputState();
}

class _CommonInputState extends State<CommonInput> {
  Internationalization _int;

  @override
  Widget build(BuildContext context) {
    _int = Internationalization(context);

    final Color primary = Theme.of(context).primaryColor;

    return Theme(
      data: (!widget.isDark)
          ? Theme.of(context)
          : Theme.of(context).copyWith(
              primaryColor: Colors.white,
              inputDecorationTheme: InputDecorationTheme(
                fillColor: whiteColor,
                focusColor: whiteColor,
                hoverColor: whiteColor,
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: whiteColor),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: whiteColor),
                ),
                border: UnderlineInputBorder(
                  borderSide: BorderSide(color: whiteColor),
                ),
                disabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: whiteColor.withOpacity(0.5)),
                ),
              ),
            ),
      child: InkWell(
        onTap: widget.onTap,
        child: IgnorePointer(
          ignoring: widget.onTap != null,
          child: Container(
            margin: const EdgeInsets.fromLTRB(0, 4, 0, 4),
            child: TextFormField(
              cursorColor: (!widget.isDark) ? primary : whiteColor,
              controller: widget.controller,
              obscureText: widget.obscureText,
              style: (!widget.isDark)
                  ? Theme.of(context).textTheme.bodyText1
                  : Theme.of(context).textTheme.bodyText2,
              decoration: InputDecoration(
                labelText: widget.hint,
                labelStyle: Theme.of(context).textTheme.bodyText1.copyWith(
                      color: (!widget.isDark)
                          ? primary.withOpacity(0.8)
                          : whiteColor.withOpacity(0.8),
                    ),
                prefixIcon: widget.prefixIcon,
                hintStyle: Theme.of(context).textTheme.bodyText1.copyWith(
                      color: (!widget.isDark)
                          ? primary.withOpacity(0.5)
                          : whiteColor.withOpacity(0.5),
                    ),
              ),
              validator: _validateField,
            ),
          ),
        ),
      ),
    );
  }

  String _validateField(String text) {
    if (text.trim().isEmpty) {
      return _int.getString(emptyFieldKey);
    } else {
      if (widget.isEmail) {
        bool emailValid = RegExp(
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(text.trim());
        if (!emailValid) return _int.getString(validateEmailKey);
      }
    }
    return null;
  }
}
