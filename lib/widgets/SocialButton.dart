import 'package:auth/enums/AuthType.dart';
import 'package:flutter/material.dart';

class SocialButton extends StatefulWidget {
  final Function callback;
  final AuthType type;

  SocialButton({this.callback, @required this.type});

  @override
  _SocialButtonState createState() => _SocialButtonState();
}

class _SocialButtonState extends State<SocialButton> {
  TextStyle textStyle;
  Color background;

  String image;
  String text;

  @override
  void initState() {
    super.initState();

    switch (widget.type) {
      case AuthType.apple:
        textStyle = TextStyle(color: Colors.black);
        background = Colors.white;
        image = "apple";
        text = "Apple";
        break;
      case AuthType.google:
        textStyle = TextStyle(color: Colors.black);
        background = Colors.white;
        image = "google";
        text = "Google";
        break;
        break;
      case AuthType.twitter:
        textStyle = TextStyle(color: Colors.black);
        background = Colors.white;
        image = "twitter";
        text = "Twitter";
        break;
      case AuthType.facebook:
        textStyle = TextStyle(color: Colors.white);
        background = Color(0xff3b5998);
        image = "facebook";
        text = "Facebook";
        break;
      case AuthType.github:
        textStyle = TextStyle(color: Colors.white);
        background = Color(0xff24292f);
        image = "github";
        text = "Github";
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 2),
      child: FlatButton(
        onPressed: widget.callback,
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
              "$text Signin",
              style: textStyle,
            ),
          ],
        ),
      ),
    );
  }
}
