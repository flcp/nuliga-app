import 'package:flutter/material.dart';
import 'package:nuliga_app/localization/app_localizations.dart';
import 'package:nuliga_app/pages/shared/constants.dart';

class DashboardSection extends StatelessWidget {
  final String title;
  final Widget child;
  final VoidCallback onViewAll;
  final bool isContentWidthConstrained;

  const DashboardSection({
    super.key,
    required this.title,
    required this.child,
    required this.onViewAll,
    this.isContentWidthConstrained = true,
  });

  @override
  Widget build(BuildContext context) {
    final padding = isContentWidthConstrained ? Constants.pagePadding : 0.0;
    final localization = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Constants.pagePadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: Theme.of(context).textTheme.titleMedium),
              TextButton(
                onPressed: onViewAll,
                child: Text(localization.viewAll_button),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: padding),
          child: child,
        ),
      ],
    );
  }
}
