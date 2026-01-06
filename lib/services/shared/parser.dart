import 'package:html/dom.dart';

class Parser {
  static const tableClass = "result-set";

  static const int matchesDateIndex = 1;
  static const int matchesTimeIndex = 2;
  static const int matchesLocationIndex = 3;
  static const int matchesHomeTeamIndex = 4;
  static const int matchesOpponentTeamIndex = 5;
  static const int matchesResultIndex = 6;

  // date in format 25.10.2025
  // time in format 14:00
  // time sometimes 14:05 v
  // TODO: refactor and use below helper
  static DateTime getMatchDateTime(Element dateCell, Element timeCell) {
    final dateParts = dateCell.text.trim().split(".");
    final timeParts = timeCell.text.trim().split(" ")[0].split(":");

    if (dateParts.length < 3 || timeParts.length < 2) {
      return DateTime.fromMicrosecondsSinceEpoch(0);
    }

    return DateTime(
      int.parse(dateParts[2]), // year
      int.parse(dateParts[1]), // month
      int.parse(dateParts[0]), // day
      int.parse(timeParts[0]), // hour
      int.parse(timeParts[1]), // minute
    );
  }

  static List<int> getCellTupleOrZero(List<Element> cells, int index) {
    // e.g. "9:1"
    final cell = getCellOrEmpty(cells, index);
    if (cell.isEmpty || !cell.contains(':')) return [0, 0];

    final numbers = cell.split(":");
    if (numbers.length < 2) return [0, 0];

    final firstNumber = convertToIntOrZero(numbers[0]);
    final secondNumber = convertToIntOrZero(numbers[1]);

    return [firstNumber, secondNumber];
  }

  static int getCellOrZero(List<Element> cells, int index) {
    final cell = getCellOrEmpty(cells, index);
    return convertToIntOrZero(cell);
  }

  static int convertToIntOrZero(String input) {
    final result = int.tryParse(input);

    if (result == null || result < 0) {
      return 0;
    }

    return result;
  }

  static String getCellOrEmpty(List<Element> cells, int index) {
    if (index >= cells.length) return "";

    return cells[index].text.trim();
  }

  static String getLinkOrEmpty(List<Element> cells, int index, String baseUrl) {
    if (index >= cells.length) return "";

    final relativeUrl =
        cells[index].querySelector('a')?.attributes['href'] ?? "";

    if (relativeUrl.isEmpty) return "";

    return baseUrl + relativeUrl;
  }

  static List<String> getPlayersLinkTextOrEmpty(
    List<Element> cells,
    int index,
  ) {
    if (index >= cells.length) return [];

    return cells[index]
        .querySelectorAll('a')
        .map((a) => a.text.trim())
        .toList();
  }
}
