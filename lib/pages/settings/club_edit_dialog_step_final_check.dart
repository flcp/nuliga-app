import 'package:flutter/material.dart';
import 'package:nuliga_app/model/validation_result.dart';
import 'package:nuliga_app/services/settings_service.dart';
import 'package:nuliga_app/services/shared/future_async_snapshot.dart';

class ClubEditDialogStepFinalCheck extends StatelessWidget {
  final String rankingUrl;
  final String shortName;
  final String selectedTeamName;
  final String matchesUrl;

  final settingsService = SettingsService();

  ClubEditDialogStepFinalCheck({
    super.key,
    required this.rankingUrl,
    required this.shortName,
    required this.selectedTeamName,
    required this.matchesUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ValidationListItem(
          title: "Liga Überblick URL",
          subtitle: rankingUrl,
          isValid: _checkRankingUrlValid,
        ),
        ValidationListItem(
          title: "Spielplan URL",
          subtitle: matchesUrl,
          isValid: _checkMatchesUrlValid,
        ),
        ValidationListItem(
          title: "Team",
          subtitle: selectedTeamName,
          isValid: _checkTeamValid,
        ),
        ValidationListItem(
          title: "Team Kürzel",
          subtitle: shortName,
          isValid: _checkShortNameValid,
        ),
      ],
    );
  }

  Future<ValidationResult> _checkShortNameValid() async {
    if (shortName.isEmpty) {
      return ValidationResult.invalid;
    }

    return settingsService.validateShortName(shortName);
  }

  Future<ValidationResult> _checkTeamValid() async {
    return settingsService.validateTeam(selectedTeamName);
  }

  Future<ValidationResult> _checkMatchesUrlValid() async {
    if (matchesUrl.isEmpty) {
      return ValidationResult.invalid;
    }

    return settingsService.validateMatchupsUrl(matchesUrl);
  }

  Future<ValidationResult> _checkRankingUrlValid() async {
    if (rankingUrl.isEmpty) {
      return ValidationResult.invalid;
    }

    return settingsService.validateRankingTableUrl(rankingUrl);
  }
}

class ValidationListItem extends StatelessWidget {
  final Future<ValidationResult> Function() isValid;
  final String title;
  final String subtitle;

  const ValidationListItem({
    super.key,
    required this.isValid,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ValidationResult>(
      future: isValid(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        final isValid = getDataOrDefault(snapshot, ValidationResult.unknown);
        return ListTile(
          trailing: switch (isValid) {
            ValidationResult.valid => Icon(Icons.check, color: Colors.green),
            ValidationResult.invalid => Icon(Icons.close, color: Colors.red),
            _ => Icon(Icons.help, color: Colors.grey),
          },

          title: Text(title),
          subtitle: Text(subtitle),
        );
      },
    );
  }
}
