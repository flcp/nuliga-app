import 'package:flutter/material.dart';
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

  Future<bool> _checkShortNameValid() async {
    return settingsService.validateShortName(shortName) ?? false;
  }

  Future<bool> _checkTeamValid() async {
    return settingsService.validateTeam(selectedTeamName);
  }

  Future<bool> _checkMatchesUrlValid() async {
    return settingsService.validateMatchupsUrl(matchesUrl);
  }

  Future<bool> _checkRankingUrlValid() async {
    return settingsService.validateRankingTableUrl(rankingUrl);
  }
}

class ValidationListItem extends StatelessWidget {
  final Future<bool> Function() isValid;
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
    return FutureBuilder<bool>(
      future: isValid(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        final isValid = getDataOrDefault(snapshot, false);
        return ListTile(
          trailing: isValid
              ? Icon(Icons.check, color: Colors.green)
              : Icon(Icons.close, color: Colors.red),
          title: Text(title),
          subtitle: Text(subtitle),
        );
      },
    );
  }
}
