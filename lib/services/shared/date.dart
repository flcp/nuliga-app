class Date {
  static const _weekdayNames = [
    "Montag",
    "Dienstag",
    "Mittwoch",
    "Donnerstag",
    "Freitag",
    "Samstag",
    "Sonntag",
  ];

  static const _monthNames = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec",
  ];

  static String getDateString(DateTime date) {
    return "${date.day}. ${_getMonth(date)} ${date.year}";
  }

  static String getShortDateString(DateTime date) {
    return "${date.day}. ${_getMonth(date)}";
  }

  static String getLongDateString(DateTime date) {
    return "${_getWeekdayName(date)}, ${date.day}. ${_getMonth(date)} ${date.year}";
  }

  static String _getMonth(DateTime date) {
    return _monthNames[date.month - 1];
  }

  static String _getWeekdayName(DateTime date) {
    return _weekdayNames[date.weekday - 1];
  }
}
