import 'package:flutter/material.dart';
import 'package:nuliga_app/localization/app_localizations.dart';
import 'package:nuliga_app/services/shared/model/validation_result.dart';
import 'package:nuliga_app/services/settings/settings_service.dart';
import 'package:nuliga_app/services/shared/future_async_snapshot.dart';

class ClubEditDialogStepFinalCheck extends StatefulWidget {
  final String rankingUrl;
  final String matchesUrl;
  final String selectedTeamName;
  final String shortName;

  const ClubEditDialogStepFinalCheck({
    super.key,
    required this.rankingUrl,
    required this.matchesUrl,
    required this.selectedTeamName,
    required this.shortName,
  });

  @override
  State<ClubEditDialogStepFinalCheck> createState() =>
      _ClubEditDialogStepFinalCheckState();
}

class _ClubEditDialogStepFinalCheckState
    extends State<ClubEditDialogStepFinalCheck> {
  final settingsService = SettingsService();

  late Future<ValidationResult> _rankingUrlCachedFuture;
  late Future<ValidationResult> _matchesUrlCachedFuture;
  late Future<ValidationResult> _teamCachedFuture;
  late Future<ValidationResult> _shortNameCachedFuture;

  @override
  void initState() {
    super.initState();
    _rankingUrlCachedFuture = _checkRankingUrlValid(widget.rankingUrl);
    _matchesUrlCachedFuture = _checkMatchesUrlValid(widget.matchesUrl);
    _teamCachedFuture = _checkTeamValid(widget.selectedTeamName);
    _shortNameCachedFuture = _checkShortNameValid(widget.shortName);
  }

  @override
  void didUpdateWidget(ClubEditDialogStepFinalCheck oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.rankingUrl != widget.rankingUrl) {
      _rankingUrlCachedFuture = _checkRankingUrlValid(widget.rankingUrl);
    }

    if (oldWidget.matchesUrl != widget.matchesUrl) {
      _matchesUrlCachedFuture = _checkMatchesUrlValid(widget.matchesUrl);
    }

    if (oldWidget.selectedTeamName != widget.selectedTeamName) {
      _teamCachedFuture = _checkTeamValid(widget.selectedTeamName);
    }

    if (oldWidget.shortName != widget.shortName) {
      _shortNameCachedFuture = _checkShortNameValid(widget.shortName);
    }
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;

    return Column(
      children: [
        ValidationListItem(
          title: localization.leagueOverviewUrl,
          value: widget.rankingUrl,
          isValidFuture: _rankingUrlCachedFuture,
        ),
        ValidationListItem(
          title: localization.matchesUrl,
          value: widget.matchesUrl,
          isValidFuture: _matchesUrlCachedFuture,
        ),
        ValidationListItem(
          title: localization.team,
          value: widget.selectedTeamName,
          isValidFuture: _teamCachedFuture,
        ),
        ValidationListItem(
          title: localization.teamShortName,
          value: widget.shortName,
          isValidFuture: _shortNameCachedFuture,
        ),
      ],
    );
  }

  Future<ValidationResult> _checkRankingUrlValid(String rankingUrl) async {
    return settingsService.validateRankingTableUrl(rankingUrl);
  }

  Future<ValidationResult> _checkShortNameValid(String shortName) async {
    return settingsService.validateShortName(shortName);
  }

  Future<ValidationResult> _checkTeamValid(String selectedTeamName) async {
    return settingsService.validateTeam(selectedTeamName);
  }

  Future<ValidationResult> _checkMatchesUrlValid(String matchesUrl) async {
    return settingsService.validateMatchupsUrl(matchesUrl);
  }
}

class ValidationListItem extends StatelessWidget {
  final Future<ValidationResult> isValidFuture;
  final String title;
  final String value;

  const ValidationListItem({
    super.key,
    required this.isValidFuture,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ValidationResult>(
      future: isValidFuture,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        final isValid = getDataOrDefault(snapshot, ValidationResult.unknown);
        return ListTile(
          trailing: switch (isValid) {
            ValidationResult.valid => Icon(Icons.check, color: Colors.green),
            ValidationResult.invalid => Icon(Icons.close, color: Colors.red),
            _ => Icon(Icons.help, color: Colors.grey),
          },

          title: Text(title),
          subtitle: Text(value),
        );
      },
    );
  }
}
