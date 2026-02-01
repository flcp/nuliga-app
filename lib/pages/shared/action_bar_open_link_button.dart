import 'package:flutter/material.dart';
import 'package:nuliga_app/services/followed-teams/followed_club.dart';
import 'package:nuliga_app/services/shared/http_urls.dart';

class ActionBarFollowedTeamOpenLinkButton extends StatelessWidget {
  const ActionBarFollowedTeamOpenLinkButton({
    super.key,
    required this.selectedFollowedTeam,
    required this.urlAccessor,
  });

  final FollowedClub? selectedFollowedTeam;
  final String Function(FollowedClub) urlAccessor;

  @override
  Widget build(BuildContext context) {
    if (selectedFollowedTeam == null) {
      return SizedBox.shrink();
    }

    return IconButton(
      icon: Icon(Icons.open_in_new),
      onPressed: () async {
        await HttpUrls.openUrl(urlAccessor(selectedFollowedTeam!));
      },
    );
  }
}

class ActionBarOpenLinkButton extends StatelessWidget {
  const ActionBarOpenLinkButton({super.key, required this.url});

  final String url;

  @override
  Widget build(BuildContext context) {
    if (url.isEmpty) {
      return SizedBox.shrink();
    }

    return IconButton(
      icon: Icon(Icons.open_in_new),
      onPressed: () async {
        await HttpUrls.openUrl(url);
      },
    );
  }
}
