import 'package:flutter/material.dart';
import 'package:nuliga_app/pages/shared/constants.dart';
import 'package:nuliga_app/pages/shared/surface_card.dart';
import 'package:provider/provider.dart';
import 'package:nuliga_app/services/followed_teams_provider.dart';
import 'club_edit_dialog.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Einstellungen'),
      ),
      body: Consumer<FollowedTeamsProvider>(
        builder: (context, provider, child) {
          return ListView(
            padding: const EdgeInsets.all(Constants.pagePadding),
            children: [
              ReorderableListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                onReorder: (oldIndex, newIndex) {
                  provider.reorderClub(oldIndex, newIndex);
                },
                children: List.generate(provider.followedTeams.length, (index) {
                  final club = provider.followedTeams[index];
                  return Dismissible(
                    direction: DismissDirection.endToStart,
                    key: Key(club.name),
                    onDismissed: (_) {
                      provider.removeClub(index);
                    },
                    background: Padding(
                      padding: const EdgeInsets.all(Constants.bigCardPadding),
                      child: Align(
                        alignment: AlignmentGeometry.centerRight,
                        child: Icon(
                          Icons.delete,
                          color: Colors.red.withAlpha(200),
                        ),
                      ),
                    ),
                    child: SurfaceCard(
                      onTap: () async {
                        final result = await Navigator.push<dynamic>(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ClubEditPage(club: club),
                          ),
                        );
                        if (result != null) {
                          provider.updateClub(index, result);
                        }
                      },
                      child: ListTile(
                        leading: ReorderableDragStartListener(
                          index: index,
                          child: const Icon(Icons.drag_handle),
                        ),
                        subtitle: Text(club.shortName),
                        title: Text(club.name),
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: () async {
                  final result = await Navigator.push<dynamic>(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ClubEditPage(),
                    ),
                  );
                  if (result != null && context.mounted) {
                    context.read<FollowedTeamsProvider>().addClub(result);
                  }
                },
                icon: const Icon(Icons.add),
                label: const Text('Club hinzufügen'),
              ),
            ],
          );
        },
      ),
    );
  }
}
