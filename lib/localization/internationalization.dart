import 'package:auth/localization/configLocalization.dart';
import 'package:flutter/material.dart';

class Internationalization {
  ConfigLocalization _localization;

  Internationalization(BuildContext context) {
    _localization = ConfigLocalization.of(context);
  }

  String getString(key) {
    return _localization.getTranslatedValue(key);
  }
}
