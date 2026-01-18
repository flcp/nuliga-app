import 'package:html/dom.dart';

class TableheaderParser {
  static const int defaultDateIndex = 1;
  static const int defaultTimeIndex = 2;
  static const int defaultLocationIndex = 3;
  static const int defaultHomeTeamIndex = 4;
  static const int defaultOpponentTeamIndex = 5;
  static const int defaultResultIndex = 6;

  static int getMatchesDateIndex(List<Element> headerCells) {
    return defaultDateIndex;
  }

  static int getTimeIndex(List<Element> headerCells) {
    return defaultTimeIndex;
  }

  static int getLocationIndex(List<Element> headerCells) {
    return _getIndexByHeaderName(
      headerCells,
      "Sporthalle",
      defaultLocationIndex,
    );
  }

  static int getHomeTeamIndex(List<Element> headerCells) {
    return _getIndexByHeaderName(
      headerCells,
      "Heimmannschaft",
      defaultHomeTeamIndex,
    );
  }

  static int getOpponentTeamIndex(List<Element> headerCells) {
    return _getIndexByHeaderName(
      headerCells,
      "Gastmannschaft",
      defaultOpponentTeamIndex,
    );
  }

  static int getResultIndex(List<Element> headerCells) {
    return _getIndexByHeaderName(headerCells, "Spiele", defaultResultIndex);
  }

  static int _getIndexByHeaderName(
    List<Element> headerCells,
    String headerText,
    int defaultMatchesDateIndex,
  ) {
    for (int i = 0; i < headerCells.length; i++) {
      final cellText = headerCells[i].text.trim();
      if (headerText.contains(cellText)) {
        // first three indices are squashed into single column
        if (i > 0) {
          i = i + 2;
        }
        return i;
      }
    }
    return defaultMatchesDateIndex;
  }

  static TableIndizes getIndices(List<Element> headerCells) {
    return TableIndizes(
      dateIndex: getMatchesDateIndex(headerCells),
      timeIndex: getTimeIndex(headerCells),
      locationIndex: getLocationIndex(headerCells),
      homeTeamIndex: getHomeTeamIndex(headerCells),
      opponentTeamIndex: getOpponentTeamIndex(headerCells),
      resultIndex: getResultIndex(headerCells),
    );
  }
}

class TableIndizes {
  final int dateIndex;
  final int timeIndex;
  final int locationIndex;
  final int homeTeamIndex;
  final int opponentTeamIndex;
  final int resultIndex;

  TableIndizes({
    required this.dateIndex,
    required this.timeIndex,
    required this.locationIndex,
    required this.homeTeamIndex,
    required this.opponentTeamIndex,
    required this.resultIndex,
  });
}
