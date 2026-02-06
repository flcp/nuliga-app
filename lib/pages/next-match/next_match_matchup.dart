import 'package:flutter/material.dart';
import 'package:nuliga_app/localization/app_localizations.dart';
import 'package:nuliga_app/services/matches/next-matches/model/future_match.dart';
import 'package:nuliga_app/pages/shared/constants.dart';

class NextMatchMatchup extends StatelessWidget {
  const NextMatchMatchup({super.key, required this.match});

  final FutureMatch match;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final l10n = AppLocalizations.of(context)!;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(Constants.bigCardPadding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            MatchupTeamText(teamName: match.homeTeam),
            const SizedBox(height: 12),
            Text(
              l10n.versus,
              style: textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.primary.withAlpha(80),
              ),
            ),
            const SizedBox(height: 12),
            MatchupTeamText(teamName: match.opponentTeam),
          ],
        ),
      ),
    );
  }
}

class MatchupTeamText extends StatelessWidget {
  const MatchupTeamText({super.key, required this.teamName});

  final String teamName;

  @override
  Widget build(BuildContext context) {
    return Text(
      teamName,
      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
        fontWeight: FontWeight.bold,
        color: Theme.of(context).colorScheme.onSurface,
      ),
      textAlign: TextAlign.center,
    );
  }
}
