import 'package:flutter/material.dart';
import 'package:nuliga_app/pages/shared/constants.dart';

class LeagueInfoCard extends StatelessWidget {
  final Widget child;
  final String title;
  final String subtitle;
  const LeagueInfoCard({
    super.key,
    required this.child,
    this.title = "",
    this.subtitle = "",
  });

  @override
  Widget build(BuildContext context) {
    final chevronColor = Theme.of(
      context,
    ).colorScheme.onPrimaryContainer.withAlpha(50);

    final greyedOutColor = Theme.of(
      context,
    ).colorScheme.onPrimaryContainer.withAlpha(120);

    return Padding(
      padding: const EdgeInsets.only(right: Constants.bigCardListSpacing),
      child: AspectRatio(
        aspectRatio: 1,
        child: Card(
          elevation: 0,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              Constants.bigCardPadding,
              Constants.bigCardPadding,
              2,
              Constants.bigCardPadding,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      if (title.isNotEmpty)
                        Text(
                          title,
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(color: greyedOutColor),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),

                      child,
                      if (subtitle.isNotEmpty) ...[
                        Text(
                          subtitle,
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(color: greyedOutColor),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ],
                  ),
                ),
                Icon(Icons.chevron_right, color: chevronColor),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
