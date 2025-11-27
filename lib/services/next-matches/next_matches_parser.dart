import 'package:html/parser.dart' as html;
import 'package:nuliga_app/model/future_match.dart';

class NextMatchesParser {
  static const _tableClass = "result-set";

  static List<FutureMatch> getEntriesAsFutureMatches(String htmlContent) {
    if (htmlContent.trim().isEmpty) {
      return [];
    }

    final document = html.parse(htmlContent);

    final table = document.querySelector('table.$_tableClass');
    if (table == null) {
      // todo, also in other test
      throw StateError('No table found with class "$_tableClass"');
    }

    final rows = table.querySelectorAll('tr');
    if (rows.isEmpty) {
      return [];
    }

    final dataRows = rows.skip(1);
    final List<FutureMatch> result = [];

    for (final row in dataRows) {
      final cells = row.querySelectorAll('td');

      result.add(FutureMatch(DateTime.now(), cells[4].text, cells[5].text));
    }
    return result;
  }
}
