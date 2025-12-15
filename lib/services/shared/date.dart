String getDateString(DateTime date) {
  return "${date.day}. ${_getMonth(date)} ${date.year}";
}

String getShortDateString(DateTime date) {
  return "${date.day}. ${_getMonth(date)}";
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

const _weekdayNames = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];

String _getWeekday(DateTime date) {
  return _weekdayNames[date.weekday - 1];
}
