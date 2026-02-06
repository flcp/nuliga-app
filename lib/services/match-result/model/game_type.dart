// ignore_for_file: non_constant_identifier_names

import 'package:nuliga_app/localization/app_localizations.dart';

enum GameType {
  ms1(parsingText: "1.HE"),
  ms2(parsingText: "2.HE"),
  ms3(parsingText: "3.HE"),
  md1(parsingText: "1.HD"),
  md2(parsingText: "2.HD"),
  xd(parsingText: "GD"),
  ws(parsingText: "DE"),
  wd(parsingText: "DD");

  final String parsingText;

  const GameType({required this.parsingText});

  static GameType getGameType(String typeString) {
    return GameType.values.firstWhere(
      (gameType) => gameType.parsingText == typeString,
      orElse: () => throw "unknown type $typeString",
    );
  }

  bool isDoubles() {
    return this == md1 || this == md2 || this == wd || this == xd;
  }
}

extension GameTypeLocalization on GameType {
  String localize(AppLocalizations localizations) {
    return switch (this) {
      GameType.ms1 => localizations.gameTypeMen1Singles,
      GameType.ms2 => localizations.gameTypeMen2Singles,
      GameType.ms3 => localizations.gameTypeMen3Singles,
      GameType.md1 => localizations.gameTypeMen1Doubles,
      GameType.md2 => localizations.gameTypeMen2Doubles,
      GameType.xd => localizations.gameTypeMixedDoubles,
      GameType.ws => localizations.gameTypeWomenSingles,
      GameType.wd => localizations.gameTypeWomenDoubles,
    };
  }
}
