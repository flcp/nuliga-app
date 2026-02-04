import 'package:flutter/material.dart';
import 'package:nuliga_app/l10n/app_localizations.dart';
import 'package:nuliga_app/pages/settings/settings_page.dart';

// TODO: use again

class NothingToDisplayIndicator extends StatelessWidget {
  const NothingToDisplayIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    final l18n = AppLocalizations.of(context)!;

    return SizedBox(
      height: 100,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(l18n.nothingToDisplay, textAlign: TextAlign.center),
        ),
      ),
    );
  }
}

class NothingToDisplayIndicatorWithSettingsButton extends StatelessWidget {
  const NothingToDisplayIndicatorWithSettingsButton({super.key});

  @override
  Widget build(BuildContext context) {
    final l18n = AppLocalizations.of(context)!;

    return SizedBox(
      height: 300,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          NothingToDisplayIndicator(),
          const SizedBox(height: 8),
          FilledButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const SettingsPage()),
              );
            },
            child: Text(l18n.settings),
          ),
        ],
      ),
    );
  }
}
