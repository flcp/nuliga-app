import 'package:flutter/material.dart';
import 'package:nuliga_app/model/followed_club.dart';
import 'package:url_launcher/url_launcher.dart';

class ActionBarOpenLinkButton extends StatelessWidget {
  const ActionBarOpenLinkButton({
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
        var uri = Uri.parse(urlAccessor(selectedFollowedTeam!));
        await launchUrl(uri);
      },
    );
  }
}
