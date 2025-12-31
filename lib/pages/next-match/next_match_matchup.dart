import 'package:flutter/material.dart';
import 'package:nuliga_app/model/future_match.dart';
import 'package:nuliga_app/pages/shared/constants.dart';

class NextMatchMatchup extends StatelessWidget {
  const NextMatchMatchup({super.key, required this.match});

  final FutureMatch match;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Card(

      child: Padding(
        padding: const EdgeInsets.all(Constants.bigCardPadding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              match.homeTeam,
              style: textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurface,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Divider(
                    color: theme.colorScheme.outline,
                    thickness: 1.5,
                    indent: 24,
                    endIndent: 12,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    "VS",
                    style: textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: Divider(
                    color: theme.colorScheme.outline,
                    thickness: 1.5,
                    indent: 12,
                    endIndent: 24,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              match.opponentTeam,
              style: textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurface,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
