// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get helloWorld => 'Hallo Welt!';

  @override
  String get settings => 'Einstellungen';

  @override
  String get addClub => 'Verein hinzufügen';

  @override
  String get editClub => 'Verein bearbeiten';

  @override
  String get clubAlreadyExists => 'Dieser Verein ist bereits vorhanden.';

  @override
  String get clubAlreadyExistsUpdateCancelled =>
      'Dieser Verein ist bereits vorhanden. Update abgebrochen.';

  @override
  String get next => 'NÄCHSTE';

  @override
  String get last => 'LETZTE';

  @override
  String get viewAll => 'Alle anzeigen';

  @override
  String get upcoming => 'Anstehend';

  @override
  String get table => 'Tabelle';

  @override
  String resultCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Ergebnisse',
      one: 'Ergebnis',
      zero: 'Keine Ergebnisse',
    );
    return '$_temp0';
  }

  @override
  String get loading => 'Lädt';

  @override
  String get nothingToDisplay => 'Nichts anzuzeigen';

  @override
  String get matchesPlayed => 'Matches gespielt';

  @override
  String get name => 'Name';

  @override
  String get points => 'Pkt';

  @override
  String get wins => 'W';

  @override
  String get draws => 'D';

  @override
  String get losses => 'L';

  @override
  String get matches => 'M';

  @override
  String get versus => 'VS';

  @override
  String get view => 'Nuliga';

  @override
  String get maps => 'Maps';

  @override
  String get homeGame => 'Heimspiel';

  @override
  String get unknown => 'Unbekannt';

  @override
  String get matchStartsIn => 'Spiel startet in';

  @override
  String get days => 'Tage';

  @override
  String get hours => 'Std';

  @override
  String get minutes => 'Min';

  @override
  String get seconds => 'Sek';

  @override
  String set(String number) {
    return 'Satz $number';
  }

  @override
  String get leagueUrl => 'Liga URL';

  @override
  String get matchesUrl => 'Spielplan URL';

  @override
  String get team => 'Verein';

  @override
  String get teamShortName => 'Team Kürzel';

  @override
  String get review => 'Überprüfen';

  @override
  String get back => 'Zurück';

  @override
  String get next_button => 'Weiter';

  @override
  String get leagueOverviewUrl => 'Liga Überblick URL';

  @override
  String get invalidUrl => 'Ungültige URL';

  @override
  String get instructions => 'Anleitung';

  @override
  String get openYourAssociationWebsite => 'Öffne die Website deines Verbandes';

  @override
  String get exampleAssociationUrl =>
      'Beispiel: https://bwbv-badminton.liga.nu';

  @override
  String get navigateToYourLeague => 'Navigiere zur Liga deines Vereines';

  @override
  String get exampleLeaguePath =>
      'Beispiel: BWBV-Ligen > Landesliga \"Oberrhein\"';

  @override
  String get copyUrlAndPasteAbove => 'Kopiere die URL und füge sie oben ein';

  @override
  String get matchPlanOverallUrl => 'Spielplan (Gesamt) URL';

  @override
  String get confirmOverwrite => 'Überschreiben bestätigen';

  @override
  String get confirmOverwriteMatchPlanUrl =>
      'Möchten Sie die aktuelle Spielplan URL wirklich überschreiben?';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get overwrite => 'Überschreiben';

  @override
  String get generateFromLeagueUrl => 'Aus Liga URL generieren';

  @override
  String get pleaseEnterLeagueUrlInStep1 =>
      'Bitte Liga URL in Schritt 1 eingeben.';

  @override
  String get noTeamFound => 'Kein Team gefunden';

  @override
  String get shortNameMaxLength => 'Kürzel darf maximal 7 Zeichen lang sein';
}
