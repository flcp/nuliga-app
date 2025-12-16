import 'package:flutter/material.dart';
import 'package:nuliga_app/model/future_match.dart';
import 'package:nuliga_app/services/next_matches_service.dart';
import 'package:nuliga_app/services/shared/future_async_snapshot.dart';
import 'package:url_launcher/url_launcher.dart';

class NextMatchesDetailsLocationIndicator extends StatelessWidget {
  final FutureMatch match;
  final String homeTeamName;

  final double size = 30.0;

  final nextMatchesService = NextMatchesService();

  NextMatchesDetailsLocationIndicator({
    required this.match,
    super.key,
    required this.homeTeamName,
  });

  @override
  Widget build(BuildContext context) {
    if (match.homeTeam == homeTeamName) {
      return Icon(
        Icons.home,
        color: Theme.of(context).disabledColor,
        size: size,
      );
    }

    return FutureBuilder(
      future: nextMatchesService.getLocationMapsLink(match),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox(
            width: size,
            height: size,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation(Colors.grey.shade200),
            ),
          );
        }

        final locationMapsLink = getDataOrDefault(snapshot, "");

        if (locationMapsLink.isEmpty || !locationMapsLink.startsWith("http")) {
          return Icon(
            Icons.directions,
            size: size,
            color: Theme.of(context).disabledColor,
          );
        }

        Uri uri;

        try {
          uri = Uri.parse(locationMapsLink);
        } on FormatException {
          return SizedBox.shrink();
        }

        // sizedbox, sonst verschiebt sich iconbutton gegenueber icon
        return Container(
          padding: const EdgeInsets.all(8), // space between icon and circle
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
          ),
          child: SizedBox(
            height: size,
            width: size,
            child: IconButton(
              padding: EdgeInsets.zero,
              icon: Icon(
                Icons.directions,
                size: size,
                color: Theme.of(context).colorScheme.onSurface,
              ),
              onPressed: () async {
                await launchUrl(uri);
              },
            ),
          ),
        );
      },
    );
  }
}
