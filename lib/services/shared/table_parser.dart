import 'dart:developer' as developer;
import 'package:html/dom.dart';
import 'package:html/parser.dart' as html;
import 'package:nuliga_app/services/matches/tableheader_parser.dart';

class MatchesTableParser {
  static const tableClass = "result-set";

  List<Element> getTableRows(String htmlContent) {
    if (htmlContent.trim().isEmpty) {
      developer.log("Empty html received", level: 800);
      return [];
    }

    final document = html.parse(htmlContent);

    final table = document.querySelector('table.$tableClass');
    if (table == null) {
      developer.log("Table with class $tableClass not found", level: 800);
      return [];
    }

    final rows = table.querySelectorAll('tr');
    if (rows.isEmpty) {
      developer.log("No rows found", level: 800);
      return [];
    }

    return rows;
  }

  List<List<Element>> getDataRows(List<Element> rows) {
    return rows
        .map((row) => row.querySelectorAll('td'))
        .where((cells) => cells.isNotEmpty)
        .toList();
  }

  TableIndizes getTableIndizesFromHeaderRow(List<Element> rows) {
    final headerRow = rows.first.querySelectorAll('th');
    final tableIndizes = TableheaderParser.getIndices(headerRow);
    return tableIndizes;
  }
}
