import 'package:flutter/material.dart';
import 'package:nuliga_app/l10n/app_localizations.dart';
import 'package:nuliga_app/services/matches/next-matches/model/future_match.dart';
import 'package:nuliga_app/pages/shared/constants.dart';
import 'package:nuliga_app/services/location/location_service.dart';
import 'package:nuliga_app/services/shared/future_async_snapshot.dart';
import 'package:nuliga_app/services/shared/http_urls.dart';

class NextMatchInfo extends StatelessWidget {
  NextMatchInfo({super.key, required this.match, required this.teamName});
  final locationService = LocationService();
  final FutureMatch match;
  final String teamName;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(Constants.bigCardPadding),
        child: FutureBuilder(
          future: locationService.getLocation(match),
          builder: (context, asyncSnapshot) {
            if (asyncSnapshot.connectionState == ConnectionState.waiting) {
              return Center();
            }

            final data = getDataOrDefault(asyncSnapshot, "");
            final locationMultiline = LocationService.convertToMultilineAddress(
              data,
            );

            return Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.location_on),
                    const SizedBox(width: 18),
                    Expanded(
                      child: LocationText(
                        isHomeTeam: match.isHomeTeam(teamName),
                        locationMultiline: locationMultiline,
                      ),
                    ),
                  ],
                ),
                if (match.locationUrl.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton.icon(
                          onPressed: () async {
                            await HttpUrls.openUrl(match.locationUrl);
                          },
                          icon: Icon(Icons.open_in_new),
                          label: Text(l10n.nuliga_button),
                        ),
                        SizedBox(width: 16),
                        FilledButton.icon(
                          onPressed: () async {
                            if (match.locationUrl.isEmpty) return;
                            final mapsLink =
                                LocationService.convertToGoogleMapsLink(
                                  locationMultiline.join(", "),
                                );
                            await HttpUrls.openUrl(mapsLink);
                          },
                          icon: Icon(Icons.directions),
                          label: Text(l10n.maps_button),
                        ),
                      ],
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class LocationText extends StatelessWidget {
  const LocationText({
    super.key,
    required this.locationMultiline,
    required this.isHomeTeam,
  });

  final List<String> locationMultiline;
  final bool isHomeTeam;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    if (isHomeTeam) {
      return Text(l10n.homeGame);
    }

    if (locationMultiline.toList().isEmpty) {
      return Text(l10n.unknown);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: locationMultiline
          .map(
            (locationPart) => Text(
              locationPart,
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
              softWrap: true,
              style: TextStyle(height: 1.8),
            ),
          )
          .toList(),
    );
  }
}
