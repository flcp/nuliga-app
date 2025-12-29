String getDateString(DateTime date) {
  return "${date.day}. ${_getMonth(date)} ${date.year}";
}

String getShortDateString(DateTime date) {
  return "${date.day}. ${_getMonth(date)}";
}

String getLongDateString(DateTime date) {
  return "${_getWeekdayName(date)}, ${date.day}. ${_getMonth(date)} ${date.year}";
}

const _monthNames = [
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

String _getMonth(DateTime date) {
  return _monthNames[date.month - 1];
}

const _weekdayNames = [
  "Montag",
  "Dienstag",
  "Mittwoch",
  "Donnerstag",
  "Freitag",
  "Samstag",
  "Sonntag",
];

String _getWeekdayName(DateTime date) {
  return _weekdayNames[date.weekday - 1];
}
