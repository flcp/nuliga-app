import 'package:flutter/material.dart';
import 'package:nuliga_app/model/future_match.dart';
import 'package:nuliga_app/pages/shared/constants.dart';
import 'package:nuliga_app/services/location_service.dart';
import 'package:nuliga_app/services/shared/date.dart';
import 'package:nuliga_app/services/shared/future_async_snapshot.dart';
import 'package:url_launcher/url_launcher.dart';

class NextMatchInfo extends StatelessWidget {
  NextMatchInfo({super.key, required this.match, required this.teamName});

  final locationService = LocationService();
  final FutureMatch match;
  
  final String teamName;

  @override
  Widget build(BuildContext context) {
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
                  children: [
                    Icon(Icons.calendar_today),
                    const SizedBox(width: 12),
                    Text("Datum"),
                    const Spacer(),
                    Text(Date.getLongDateString(match.time)),
                  ],
                ),
                const SizedBox(height: 16),

                Row(
                  children: [
                    Icon(Icons.access_time),
                    const SizedBox(width: 12),
                    Text("Uhrzeit"),
                    const Spacer(),
                    Text(
                      "${match.time.hour}:${match.time.minute.toString().padLeft(2, "0")} Uhr",
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.location_on),
                    const SizedBox(width: 12),
                    Text("Location"),
                    const SizedBox(width: 24),

                    Expanded(
                      child: LocationText(isHomeTeam: match.isHomeTeam(teamName), locationMultiline: locationMultiline),
                    ),
                  ],
                ),

                if (match.locationUrl.isNotEmpty)
                  Row(
                    children: [
                      const Spacer(),
                      IconButton(
                        onPressed: () async {
                          if (match.locationUrl.isNotEmpty) {
                            final bwbvUri = Uri.parse(match.locationUrl);
                            launchUrl(bwbvUri);
                          }
                        },
                        icon: Icon(Icons.open_in_new),
                      ),
                      IconButton(
                        onPressed: () async {
                          if (match.locationUrl.isEmpty) return;
                          final mapsLink =
                              LocationService.convertToGoogleMapsLink(
                                locationMultiline.join(", "),
                              );
                          Uri mapsLinkUri = Uri.parse(mapsLink);
                          if (mapsLink.isNotEmpty) {
                            launchUrl(mapsLinkUri);
                          }
                        },
                        icon: Icon(Icons.directions),
                      ),
                    ],
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
    required this.locationMultiline, required this.isHomeTeam,
  });

  final List<String> locationMultiline;
  final bool isHomeTeam;

  @override
  Widget build(BuildContext context) {
    if (isHomeTeam) {
      return Text("Heimspiel", textAlign: TextAlign.right,);
    }

    if (locationMultiline.toList().isEmpty) {
      return Text("Unbekannt", textAlign: TextAlign.right,);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: locationMultiline
          .map(
            (locationPart) => Text(
              locationPart,
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
              softWrap: true,
              textAlign: TextAlign.right,
            ),
          )
          .toList(),
    );
  }
}
