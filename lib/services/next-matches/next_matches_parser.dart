import 'package:html/dom.dart';
import 'package:html/parser.dart' as html;
import 'package:nuliga_app/model/future_match.dart';

class NextMatchesParser {
  static const _tableClass = "result-set";

  static const int date = 1;
  static const int time = 2;
  static const int location = 3;
  static const int homeTeam = 4;
  static const int opponentTeam = 5;

  static List<FutureMatch> getEntriesAsFutureMatches(String htmlContent) {
    if (htmlContent.trim().isEmpty) {
      return [];
    }

    final document = html.parse(htmlContent);

    final table = document.querySelector('table.$_tableClass');
    if (table == null) {
      return [];
    }

    final rows = table.querySelectorAll('tr');
    if (rows.isEmpty) {
      return [];
    }

    final dataRows = rows.skip(1).toList();
    final List<FutureMatch> result = [];

    for (int i = 0; i < dataRows.length; i++) {
      final row = dataRows[i];
      final cells = row.querySelectorAll('td');

      if (i > 0 && cells[date].text.trim().isEmpty) {
        cells[date] = dataRows[i-1].querySelectorAll('td')[date];
      }
      final dateTime = getMatchDateTime(cells[date], cells[time]);

      result.add(FutureMatch(dateTime, cells[homeTeam].text.trim(), cells[opponentTeam].text.trim()));
    }
    return result;
  }

  // date in format 25.10.2025
  // time in format 14:00
  static DateTime getMatchDateTime(Element dateCell, Element timeCell) {
    final dateParts = dateCell.text.trim().split(".");
    final timeParts = timeCell.text.trim().split(":");

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
} 