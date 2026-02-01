import 'package:flutter/material.dart';
import 'package:nuliga_app/l10n/app_localizations.dart';
import 'package:nuliga_app/services/localization/localization_provider.dart';
import 'package:provider/provider.dart';

class LocalizationDropdownMenu extends StatelessWidget {
  const LocalizationDropdownMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LocalizationProvider>(context);
    final locale = provider.locale;

    return DropdownButtonHideUnderline(
      child: DropdownButton(
        value: locale,
        icon: Container(width: 12),
        items: AppLocalizations.supportedLocales.map((nextLocale) {
          return DropdownMenuItem(
            value: nextLocale,
            onTap: () {
              final provider = Provider.of<LocalizationProvider>(
                context,
                listen: false,
              );

              provider.setLocale(nextLocale);
            },
            child: Center(child: Text(nextLocale.toString())),
          );
        }).toList(),
        onChanged: (_) {},
      ),
    );
  }
}
