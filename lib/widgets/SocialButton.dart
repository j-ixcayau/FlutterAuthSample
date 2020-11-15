import 'package:auth/common/dialogs/CommonDialogs.dart';
import 'package:auth/enums/AuthType.dart';
import 'package:auth/localization/Internationalization.dart';
import 'package:auth/utils/Utils.dart';
import 'package:flutter/material.dart';

class SocialButton extends StatefulWidget {
  final Function callback;
  final AuthType type;

  SocialButton({@required this.callback, @required this.type});

  @override
  _SocialButtonState createState() => _SocialButtonState();
}

class _SocialButtonState extends State<SocialButton> {
  Internationalization _int;

  TextStyle textStyle;
  Color background;

  String image;
  String text;

  @override
  void initState() {
    super.initState();

    switch (widget.type) {
      case AuthType.apple:
        textStyle = TextStyle(color: whiteColor);
        background = blackColor;
        text = "Apple";
        break;
      case AuthType.google:
        textStyle = TextStyle(color: Colors.black);
        background = googleColor;
        text = "Google";
        break;
        break;
      case AuthType.twitter:
        textStyle = TextStyle(color: Colors.black);
        background = twitterColor;
        text = "Twitter";
        break;
      case AuthType.facebook:
        textStyle = TextStyle(color: Colors.white);
        background = facebookColor;
        text = "Facebook";
        break;
      case AuthType.github:
        textStyle = TextStyle(color: Colors.white);
        background = githubColor;
        text = "Github";
        break;
      default:
        break;
    }
    image = text.trim().toLowerCase();
  }

  @override
  Widget build(BuildContext context) {
    _int = Internationalization(context);

    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 2),
      child: FlatButton(
        onPressed: widget.callback ?? _showAlert,
        color: background,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/social/$image.png",
              width: 30,
              height: 30,
            ),
            SizedBox(width: 10),
            Text(
              "$text ${_int.getString(loginKey)}",
              style: textStyle,
            ),
          ],
        ),
      ),
    );
  }

  void _showAlert() {
    commonOkDialog(context,
        Internationalization(context).getString(optionNotAvailableKey));
  }
}
