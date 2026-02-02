import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nuliga_app/services/localization/localization_provider.dart';
import 'package:provider/provider.dart';

class Date {
  final String locale;

  Date({this.locale = 'de_DE'});

  String getDateString(DateTime date) {
    return "${date.day}. ${_getMonth(date)} ${date.year}";
  }

  String getShortDateString(DateTime date) {
    return "${date.day}. ${_getMonth(date)}";
  }

  String getLongDateString(DateTime date) {
    return "${_getWeekdayName(date)}, ${date.day}. ${_getMonth(date)} ${date.year}";
  }

  String _getMonth(DateTime date) {
    return DateFormat.MMM(locale).format(date);
  }

  String _getWeekdayName(DateTime date) {
    return DateFormat.EEEE(locale).format(date);
  }
}

extension DateExtension on BuildContext {
  Date getDate() =>
      Date(locale: watch<LocalizationProvider>().locale.toString());
}
