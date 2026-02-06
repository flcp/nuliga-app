import 'package:flutter/material.dart';
import 'package:nuliga_app/localization/app_localizations.dart';
import 'package:nuliga_app/services/followed-teams/followed_club.dart';
import 'package:nuliga_app/pages/settings/settings_page.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class DashboardHeaderNavigation extends StatefulWidget {
  const DashboardHeaderNavigation({
    super.key,
    required this.teams,
    required this.itemScrollController,
    required this.itemPositionsListener,
  });

  final List<FollowedClub> teams;
  final ItemScrollController itemScrollController;
  final ItemPositionsListener itemPositionsListener;

  @override
  State<DashboardHeaderNavigation> createState() =>
      _DashboardHeaderNavigationState();
}

class _DashboardHeaderNavigationState extends State<DashboardHeaderNavigation> {
  Iterable<int> _visibleIndices = Iterable.empty();
  late VoidCallback _positionsListener;

  @override
  void initState() {
    super.initState();

    _positionsListener = () {
      final newPositions = widget.itemPositionsListener.itemPositions.value;
      final newIndices = newPositions.map((pos) => pos.index).toList();

      if (_visibleIndices.length != newIndices.length ||
          !_visibleIndices.every((element) => newIndices.contains(element))) {
        setState(() {
          _visibleIndices = newIndices;
        });
      }
    };

    widget.itemPositionsListener.itemPositions.addListener(_positionsListener);
  }

  @override
  void dispose() {
    widget.itemPositionsListener.itemPositions.removeListener(
      _positionsListener,
    );
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Row(
      children: [
        Expanded(
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              ...widget.teams.map(
                (team) => TextButton(
                  child: Text(
                    team.shortName,
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color:
                          _visibleIndices.contains(widget.teams.indexOf(team))
                          ? Theme.of(context).colorScheme.primary
                          : Colors.grey.shade300,
                    ),
                  ),
                  onPressed: () {
                    widget.itemScrollController.scrollTo(
                      index: widget.teams.indexOf(team),
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        PopupMenuButton<String>(
          onSelected: (value) {
            if (value == 'settings') {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const SettingsPage()),
              );
            }
          },
          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            PopupMenuItem<String>(
              value: 'settings',
              child: Text(l10n.settings),
            ),
          ],
          icon: Icon(Icons.menu),
        ),
        SizedBox(width: 8),
      ],
    );
  }
}
