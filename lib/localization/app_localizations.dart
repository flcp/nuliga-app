import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'localization/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
  ];

  /// Settings page title
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// Title when adding a club
  ///
  /// In en, this message translates to:
  /// **'Add Club'**
  String get addClub;

  /// Title when editing a club
  ///
  /// In en, this message translates to:
  /// **'Edit Club'**
  String get editClub;

  /// Error message when trying to add a duplicate club
  ///
  /// In en, this message translates to:
  /// **'This club already exists.'**
  String get clubAlreadyExists;

  /// Error message when trying to update to a duplicate club
  ///
  /// In en, this message translates to:
  /// **'This club already exists. Update cancelled.'**
  String get clubAlreadyExistsUpdateCancelled;

  /// Label for next matches section
  ///
  /// In en, this message translates to:
  /// **'NEXT'**
  String get next;

  /// Label for last matches section
  ///
  /// In en, this message translates to:
  /// **'LAST'**
  String get last;

  /// Button to view all items
  ///
  /// In en, this message translates to:
  /// **'View all'**
  String get viewAll_button;

  /// Label for upcoming matches
  ///
  /// In en, this message translates to:
  /// **'Upcoming'**
  String get upcoming;

  /// Label for league table
  ///
  /// In en, this message translates to:
  /// **'Table'**
  String get table;

  /// Text for result or results
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No results} =1{Result} other{Results}}'**
  String resultCount(num count);

  /// Loading indicator text
  ///
  /// In en, this message translates to:
  /// **'Loading'**
  String get loading;

  /// Label for matches played
  ///
  /// In en, this message translates to:
  /// **'Matches played'**
  String get matchesPlayed;

  /// Column header for team name
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// Short label for points
  ///
  /// In en, this message translates to:
  /// **'Pts'**
  String get points;

  /// Short label for wins
  ///
  /// In en, this message translates to:
  /// **'W'**
  String get wins;

  /// Short label for draws
  ///
  /// In en, this message translates to:
  /// **'D'**
  String get draws;

  /// Short label for losses
  ///
  /// In en, this message translates to:
  /// **'L'**
  String get losses;

  /// Short label for matches
  ///
  /// In en, this message translates to:
  /// **'M'**
  String get matches;

  /// Versus label between teams
  ///
  /// In en, this message translates to:
  /// **'VS'**
  String get versus;

  /// Button to view details on nuliga
  ///
  /// In en, this message translates to:
  /// **'Nuliga'**
  String get nuliga_button;

  /// Button to open in maps
  ///
  /// In en, this message translates to:
  /// **'Maps'**
  String get maps_button;

  /// Label for home game
  ///
  /// In en, this message translates to:
  /// **'Home game'**
  String get homeGame;

  /// Label for unknown location or data
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get unknown;

  /// Countdown label
  ///
  /// In en, this message translates to:
  /// **'Match starts in'**
  String get matchStartsIn;

  /// Label for days in countdown
  ///
  /// In en, this message translates to:
  /// **'Days'**
  String get days;

  /// Label for hours in countdown
  ///
  /// In en, this message translates to:
  /// **'Hrs'**
  String get hours;

  /// Label for minutes in countdown
  ///
  /// In en, this message translates to:
  /// **'Min'**
  String get minutes;

  /// Label for seconds in countdown
  ///
  /// In en, this message translates to:
  /// **'Sec'**
  String get seconds;

  /// Label for set number
  ///
  /// In en, this message translates to:
  /// **'Set {number}'**
  String set(String number);

  /// Label for league URL
  ///
  /// In en, this message translates to:
  /// **'League URL'**
  String get leagueUrl;

  /// Label for matches URL
  ///
  /// In en, this message translates to:
  /// **'Matches URL'**
  String get matchesUrl;

  /// Label for team
  ///
  /// In en, this message translates to:
  /// **'Team'**
  String get team;

  /// Label for team short name
  ///
  /// In en, this message translates to:
  /// **'Team Abbreviation'**
  String get teamShortName;

  /// Label for final review step
  ///
  /// In en, this message translates to:
  /// **'Review'**
  String get review;

  /// Back button label
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back_button;

  /// Next button label
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next_button;

  /// Label for league overview URL field
  ///
  /// In en, this message translates to:
  /// **'League Overview URL'**
  String get leagueOverviewUrl;

  /// Validation error for invalid URL
  ///
  /// In en, this message translates to:
  /// **'Invalid URL'**
  String get invalidUrl;

  /// Label for instructions section
  ///
  /// In en, this message translates to:
  /// **'Instructions'**
  String get instructions;

  /// Instruction step
  ///
  /// In en, this message translates to:
  /// **'Open the website of your association'**
  String get openYourAssociationWebsite;

  /// Example text for association URL
  ///
  /// In en, this message translates to:
  /// **'Example: https://bwbv-badminton.liga.nu'**
  String get exampleAssociationUrl;

  /// Instruction step
  ///
  /// In en, this message translates to:
  /// **'Navigate to your club\'s league'**
  String get navigateToYourLeague;

  /// Example text for league path
  ///
  /// In en, this message translates to:
  /// **'Example: BWBV-Ligen > Landesliga \"Oberrhein\"'**
  String get exampleLeaguePath;

  /// Instruction step
  ///
  /// In en, this message translates to:
  /// **'Copy the URL and paste it above'**
  String get copyUrlAndPasteAbove;

  /// Label for match plan URL field
  ///
  /// In en, this message translates to:
  /// **'Match Plan (Overall) URL'**
  String get matchPlanOverallUrl;

  /// Dialog title for confirming overwrite
  ///
  /// In en, this message translates to:
  /// **'Confirm Overwrite'**
  String get confirmOverwrite;

  /// Confirmation message for overwriting URL
  ///
  /// In en, this message translates to:
  /// **'Do you really want to overwrite the current match plan URL?'**
  String get confirmOverwriteMatchPlanUrl;

  /// Cancel button label
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel_button;

  /// No description provided for @overwrite_button.
  ///
  /// In en, this message translates to:
  /// **'Overwrite'**
  String get overwrite_button;

  /// Button to auto-generate URL
  ///
  /// In en, this message translates to:
  /// **'Generate from League URL'**
  String get generateFromLeagueUrl_button;

  /// Message when league URL is missing
  ///
  /// In en, this message translates to:
  /// **'Please enter League URL in step 1.'**
  String get pleaseEnterLeagueUrlInStep1;

  /// Message when no team is found
  ///
  /// In en, this message translates to:
  /// **'No team found'**
  String get noTeamFound;

  /// Validation error for short name length
  ///
  /// In en, this message translates to:
  /// **'Abbreviation may be maximum 7 characters long'**
  String get shortNameMaxLength;

  /// Label for enum match result win
  ///
  /// In en, this message translates to:
  /// **'Win'**
  String get matchResultWin;

  /// Label for enum match result loss
  ///
  /// In en, this message translates to:
  /// **'Loss'**
  String get matchResultLoss;

  /// Label for enum match result draw
  ///
  /// In en, this message translates to:
  /// **'Draw'**
  String get matchResultDraw;

  /// Label for enum match result unknown
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get matchResultUnknown;

  /// Label for 1st men's singles game type
  ///
  /// In en, this message translates to:
  /// **'1st Men\'s Singles'**
  String get gameTypeMen1Singles;

  /// Label for 2nd men's singles game type
  ///
  /// In en, this message translates to:
  /// **'2nd Men\'s Singles'**
  String get gameTypeMen2Singles;

  /// Label for 3rd men's singles game type
  ///
  /// In en, this message translates to:
  /// **'3rd Men\'s Singles'**
  String get gameTypeMen3Singles;

  /// Label for 1st men's doubles game type
  ///
  /// In en, this message translates to:
  /// **'1st Men\'s Doubles'**
  String get gameTypeMen1Doubles;

  /// Label for 2nd men's doubles game type
  ///
  /// In en, this message translates to:
  /// **'2nd Men\'s Doubles'**
  String get gameTypeMen2Doubles;

  /// Label for mixed doubles game type
  ///
  /// In en, this message translates to:
  /// **'Mixed Doubles'**
  String get gameTypeMixedDoubles;

  /// Label for women's singles game type
  ///
  /// In en, this message translates to:
  /// **'Women\'s Singles'**
  String get gameTypeWomenSingles;

  /// Label for women's doubles game type
  ///
  /// In en, this message translates to:
  /// **'Women\'s Doubles'**
  String get gameTypeWomenDoubles;

  /// Label to display when no data is present in nothingToDisplayIndicator
  ///
  /// In en, this message translates to:
  /// **'Nothing to display. Try refreshing or another URL'**
  String get nothingToDisplay;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['de', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
