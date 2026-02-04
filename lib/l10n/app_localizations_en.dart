// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get settings => 'Settings';

  @override
  String get addClub => 'Add Club';

  @override
  String get editClub => 'Edit Club';

  @override
  String get clubAlreadyExists => 'This club already exists.';

  @override
  String get clubAlreadyExistsUpdateCancelled =>
      'This club already exists. Update cancelled.';

  @override
  String get next => 'NEXT';

  @override
  String get last => 'LAST';

  @override
  String get viewAll_button => 'View all';

  @override
  String get upcoming => 'Upcoming';

  @override
  String get table => 'Table';

  @override
  String resultCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Results',
      one: 'Result',
      zero: 'No results',
    );
    return '$_temp0';
  }

  @override
  String get loading => 'Loading';

  @override
  String get nothingToDisplay => 'Nothing to display';

  @override
  String get matchesPlayed => 'Matches played';

  @override
  String get name => 'Name';

  @override
  String get points => 'Pts';

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
  String get nuliga_button => 'Nuliga';

  @override
  String get maps_button => 'Maps';

  @override
  String get homeGame => 'Home game';

  @override
  String get unknown => 'Unknown';

  @override
  String get matchStartsIn => 'Match starts in';

  @override
  String get days => 'Days';

  @override
  String get hours => 'Hrs';

  @override
  String get minutes => 'Min';

  @override
  String get seconds => 'Sec';

  @override
  String set(String number) {
    return 'Set $number';
  }

  @override
  String get leagueUrl => 'League URL';

  @override
  String get matchesUrl => 'Matches URL';

  @override
  String get team => 'Team';

  @override
  String get teamShortName => 'Team Abbreviation';

  @override
  String get review => 'Review';

  @override
  String get back_button => 'Back';

  @override
  String get next_button => 'Next';

  @override
  String get leagueOverviewUrl => 'League Overview URL';

  @override
  String get invalidUrl => 'Invalid URL';

  @override
  String get instructions => 'Instructions';

  @override
  String get openYourAssociationWebsite =>
      'Open the website of your association';

  @override
  String get exampleAssociationUrl => 'Example: https://bwbv-badminton.liga.nu';

  @override
  String get navigateToYourLeague => 'Navigate to your club\'s league';

  @override
  String get exampleLeaguePath =>
      'Example: BWBV-Ligen > Landesliga \"Oberrhein\"';

  @override
  String get copyUrlAndPasteAbove => 'Copy the URL and paste it above';

  @override
  String get matchPlanOverallUrl => 'Match Plan (Overall) URL';

  @override
  String get confirmOverwrite => 'Confirm Overwrite';

  @override
  String get confirmOverwriteMatchPlanUrl =>
      'Do you really want to overwrite the current match plan URL?';

  @override
  String get cancel_button => 'Cancel';

  @override
  String get overwrite_button => 'Overwrite';

  @override
  String get generateFromLeagueUrl_button => 'Generate from League URL';

  @override
  String get pleaseEnterLeagueUrlInStep1 =>
      'Please enter League URL in step 1.';

  @override
  String get noTeamFound => 'No team found';

  @override
  String get shortNameMaxLength =>
      'Abbreviation may be maximum 7 characters long';

  @override
  String get matchResultWin => 'Win';

  @override
  String get matchResultLoss => 'Loss';

  @override
  String get matchResultDraw => 'Draw';

  @override
  String get matchResultUnknown => 'Unknown';

  @override
  String get gameTypeMen1Singles => '1st Men\'s Singles';

  @override
  String get gameTypeMen2Singles => '2nd Men\'s Singles';

  @override
  String get gameTypeMen3Singles => '3rd Men\'s Singles';

  @override
  String get gameTypeMen1Doubles => '1st Men\'s Doubles';

  @override
  String get gameTypeMen2Doubles => '2nd Men\'s Doubles';

  @override
  String get gameTypeMixedDoubles => 'Mixed Doubles';

  @override
  String get gameTypeWomenSingles => 'Women\'s Singles';

  @override
  String get gameTypeWomenDoubles => 'Women\'s Doubles';
}
