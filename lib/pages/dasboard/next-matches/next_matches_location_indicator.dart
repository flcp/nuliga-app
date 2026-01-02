import 'package:flutter/material.dart';
import 'package:nuliga_app/model/future_match.dart';
import 'package:nuliga_app/services/location_service.dart';
import 'package:nuliga_app/services/shared/future_async_snapshot.dart';
import 'package:url_launcher/url_launcher.dart';

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
    ).colorScheme.onPrimaryContainer.withAlpha(70);

    if (match.homeTeam == homeTeamName) {
      return Icon(Icons.home, color: color, size: size);
    }

    return FutureBuilder(
      future: locationService.getLocationMapsLink(match),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox(
            width: size,
            height: size,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation(color),
            ),
          );
        }

        final locationMapsLink = getDataOrDefault(snapshot, "");

        if (locationMapsLink.isEmpty || !locationMapsLink.startsWith("http")) {
          return Icon(Icons.directions, size: size, color: color);
        }

        Uri uri;

        try {
          uri = Uri.parse(locationMapsLink);
        } on FormatException {
          return SizedBox.shrink();
        }

        // sizedbox, sonst verschiebt sich iconbutton gegenueber icon
        return SizedBox(
          height: size,
          width: size,
          child: IconButton(
            padding: EdgeInsets.zero,
            icon: Icon(
              Icons.directions,
              size: size,
              color: Theme.of(context).colorScheme.primary,
            ),
            onPressed: () async {
              await launchUrl(uri);
            },
          ),
        );
      },
    );
  }
}
