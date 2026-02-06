import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:nuliga_app/localization/app_localizations.dart';

class LocalizationProvider extends ChangeNotifier {
  Locale _locale = const Locale("de");

  Locale get locale => _locale;

  void setLocale(Locale locale) {
    if (!AppLocalizations.supportedLocales.contains(locale)) {
      developer.log(
        "Locale ${locale.toString()} is not supported.",
        name: "LocalizationProvider.setLocale",
      );
      return;
    }

    developer.log(
      'Setting locale to ${locale.toString()}',
      name: "LocalizationProvider.setLocale",
    );
    _locale = locale;
    notifyListeners();
  }
}
