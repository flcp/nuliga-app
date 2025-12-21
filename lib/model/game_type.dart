// ignore_for_file: non_constant_identifier_names

enum GameType {
  ms1(displayName: "1. Herreneinzel", parsingText: "1.HE"),
  ms2(displayName: "2. Herreneinzel", parsingText: "2.HE"),
  ms3(displayName: "3. Herreneinzel", parsingText: "3.HE"),
  md1(displayName: "1. Herrendoppel", parsingText: "1.HD"),
  md2(displayName: "2. Herrendoppel", parsingText: "2.HD"),
  xd(displayName: "Gemischtes Doppel", parsingText: "GD"),
  ws(displayName: "Dameneinzel", parsingText: "DE"),
  wd(displayName: "Damendoppel", parsingText: "DD");

  final String displayName;
  final String parsingText;

  const GameType({required this.displayName, required this.parsingText});

  static GameType getGameType(String typeString) {
    return GameType.values.firstWhere(
      (gameType) => gameType.parsingText == typeString,
      orElse: () => throw "unknown type $typeString",
    );
  }
}
