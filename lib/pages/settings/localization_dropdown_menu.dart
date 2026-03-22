import 'package:flutter/material.dart';
import 'package:nuliga_app/localization/app_localizations.dart';
import 'package:nuliga_app/services/localization/localization_provider.dart';
import 'package:provider/provider.dart';

class LocalizationDropdownMenu extends StatelessWidget {
  const LocalizationDropdownMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LocalizationProvider>(context);
    final locale = provider.locale;
    final localization = AppLocalizations.of(context)!;

    String localeDisplayName(Locale l) {
      switch (l.languageCode) {
        case 'de':
          return localization.languageGerman;
        case 'en':
          return localization.languageEnglish;
        default:
          return l.toString();
      }
    }

    return DropdownButtonHideUnderline(
      child: DropdownButton(
        value: locale,
        icon: Container(width: 12),
        items: AppLocalizations.supportedLocales.map((l) {
          return DropdownMenuItem(
            value: l,
            child: Center(child: Text(localeDisplayName(l))),
          );
        }).toList(),
        onChanged: (nextLocale) {
          if (nextLocale == null) {
            return;
          }
          final provider = Provider.of<LocalizationProvider>(
            context,
            listen: false,
          );

          provider.setLocale(nextLocale);
        },
      ),
    );
  }
}
