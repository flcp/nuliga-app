import 'package:flutter/material.dart';
import 'package:nuliga_app/model/future_match.dart';
import 'package:nuliga_app/services/next_matches_service.dart';
import 'package:nuliga_app/services/shared/future_async_snapshot.dart';
import 'package:url_launcher/url_launcher.dart';

class NextMatchesDetailsLocationIndicator extends StatelessWidget {
  final FutureMatch match;
  final String homeTeamName;

  const NextMatchesDetailsLocationIndicator({
    required this.match,
    super.key,
    required this.homeTeamName,
  });

  @override
  Widget build(BuildContext context) {
    if (match.homeTeam == homeTeamName) {
      return Text("Home");
    }

    return FutureBuilder(
      future: NextMatchesService.getLocationMapsLink(match),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation(Colors.grey.shade200),
            ),
          );
        }

        final locationMapsLink = getDataOrDefault(snapshot, "");

        if (locationMapsLink.isEmpty || !locationMapsLink.startsWith("http")) {
          return Text("?");
        }

        Uri uri;

        try {
          uri = Uri.parse(locationMapsLink);
        } on FormatException {
          return SizedBox.shrink();
        }

        return IconButton(
          icon: Icon(Icons.directions, size: 24),
          onPressed: () async {
            await launchUrl(uri);
          },
        );
      },
    );
  }
}
