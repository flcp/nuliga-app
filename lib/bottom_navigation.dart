import 'package:flutter/material.dart';
import 'package:nuliga_app/localization/app_localizations.dart';
import 'package:nuliga_app/pages/dashboard/dashboard.dart';
import 'package:nuliga_app/pages/next-matchday/next_matchday_overview_page.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  static const double _bottomBarBottomOffset = 16;

  int _selectedIndex = 0;

  // final List<Widget> _pages = [TeamOverviewPage()];
  final List<Widget> _pages = [TeamOverviewPage(), NextMatchdayOverviewPage()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;

    final items = [
      (icon: Icons.home, label: localizations.home),
      (icon: Icons.event, label: localizations.matchday),
    ];

    return Scaffold(
      extendBody: true,
      body: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: IndexedStack(index: _selectedIndex, children: _pages),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, _bottomBarBottomOffset),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(28),
            boxShadow: [
              BoxShadow(
                color: colorScheme.shadow.withValues(alpha: 0.18),
                blurRadius: 24,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                for (var index = 0; index < items.length; index++) ...[
                  if (index > 0) const SizedBox(width: 12),
                  Expanded(
                    child: _BottomNavigationItem(
                      icon: items[index].icon,
                      label: items[index].label,
                      selected: index == _selectedIndex,
                      selectedColor: colorScheme.onPrimaryContainer,
                      selectedBackgroundColor: colorScheme.primaryContainer,
                      unselectedColor: colorScheme.onSurfaceVariant,
                      onTap: () => _onItemTapped(index),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _BottomNavigationItem extends StatelessWidget {
  const _BottomNavigationItem({
    required this.icon,
    required this.label,
    required this.selected,
    required this.selectedColor,
    required this.selectedBackgroundColor,
    required this.unselectedColor,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final Color selectedColor;
  final Color selectedBackgroundColor;
  final Color unselectedColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final foregroundColor = selected ? selectedColor : unselectedColor;

    return Material(
      color: selected ? selectedBackgroundColor : Colors.transparent,
      borderRadius: BorderRadius.circular(22),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(22),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: foregroundColor),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  label,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: foregroundColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
