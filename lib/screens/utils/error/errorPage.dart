import 'package:auth/localization/Internationalization.dart';
import 'package:auth/utils/LocaleCodes.dart';
import 'package:auth/widgets/BaseScroll.dart';
import 'package:auth/widgets/CommonIcon.dart';
import 'package:auth/widgets/Text/CommonText.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';

class ErrorPage extends StatefulWidget {
  final FlutterErrorDetails error;

  ErrorPage(this.error);

  @override
  _ErrorPageState createState() => _ErrorPageState();
}

class _ErrorPageState extends State<ErrorPage> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, _initPage);
  }

  @override
  Widget build(BuildContext context) {
    return BaseScroll(
      backgroundColor: Theme.of(context).primaryColor,
      children: [
        CommonIcon(
          Icons.warning,
          customColor: Colors.red,
          size: 64,
        ),
        SizedBox(height: 15),
        CommonText(
          Internationalization(context).getString(appFailedKey),
          style: Theme.of(context).textTheme.headline1,
        ),
      ],
    );
  }

  void _initPage() {
    FirebaseCrashlytics.instance.log(widget.error.exception.toString());
  }
}
