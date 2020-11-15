import 'dart:convert';
import 'package:auth/utils/LocaleCodes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ConfigLocalization {
  final Locale locale;

  ConfigLocalization(this.locale);

  static ConfigLocalization of(BuildContext context) {
    return Localizations.of<ConfigLocalization>(context, ConfigLocalization);
  }

  Map<String, String> _localizedValues;

  Future _load() async {
    String jsonLanguage = await rootBundle
        .loadString("lib/localization/lang/${locale.languageCode}.json");

    Map<String, dynamic> mappedJson = json.decode(jsonLanguage);

    _localizedValues =
        mappedJson.map((key, value) => MapEntry(key, value.toString()));
  }

  String getTranslatedValue(String key) {
    if (_localizedValues.containsKey(key)) return _localizedValues[key];
    return _localizedValues[keyNotFound];
  }

  static const LocalizationsDelegate<ConfigLocalization> delegate =
      _ConfigLocalizationDelegate();
}

class _ConfigLocalizationDelegate
    extends LocalizationsDelegate<ConfigLocalization> {
  const _ConfigLocalizationDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'es'].contains(locale.languageCode);
  }

  @override
  Future<ConfigLocalization> load(Locale locale) async {
    ConfigLocalization localization = ConfigLocalization(locale);
    await localization._load();

    return localization;
  }

  @override
  bool shouldReload(_ConfigLocalizationDelegate old) => false;
}
