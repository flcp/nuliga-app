import 'package:flutter/material.dart';
import 'package:nuliga_app/services/matches/next-matches/model/future_match.dart';
import 'package:nuliga_app/services/location/location_service.dart';
import 'package:nuliga_app/services/shared/future_async_snapshot.dart';
import 'package:nuliga_app/services/shared/http_urls.dart';

class NextMatchesLocationIndicatorButton extends StatelessWidget {
  final FutureMatch match;
  final String homeTeamName;

  final double size = 30.0;

  final locationService = LocationService();

  NextMatchesLocationIndicatorButton({
    required this.match,
    super.key,
    required this.homeTeamName,
  });

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(
      context,
    ).colorScheme.onPrimaryContainer.withAlpha(50);

    if (match.homeTeam == homeTeamName) {
      return Icon(Icons.home, color: color);
    }

    return FutureBuilder(
      future: locationService.getLocationMapsLink(match),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox.shrink();
        }

        final locationMapsLink = getDataOrDefault(snapshot, "");

        if (locationMapsLink.isEmpty || !locationMapsLink.startsWith("http")) {
          return Icon(Icons.directions_car, color: color);
        }

        if (!HttpUrls.isUrlValid(locationMapsLink)) {
          return SizedBox.shrink();
        }

        return InkWell(
          onTap: () async {
            await HttpUrls.openUrl(locationMapsLink);
          },
          borderRadius: BorderRadius.circular(16.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
              color: Theme.of(context).colorScheme.primary,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.directions,
                size: size,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          ),
        );
      },
    );
  }
}
