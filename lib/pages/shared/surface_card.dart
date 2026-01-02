import 'package:flutter/material.dart';
import 'package:nuliga_app/pages/shared/constants.dart';

class SquareSurfaceCard extends StatelessWidget {
  final Widget child;
  final Widget? titleTrailing;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  const SquareSurfaceCard({
    super.key,
    required this.child,
    this.titleTrailing,
    this.onTap,
    this.title = "",
    this.subtitle = "",
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: Constants.bigCardListSpacing),
      child: AspectRatio(
        aspectRatio: 1,
        child: SurfaceCard(
          padding: const EdgeInsets.fromLTRB(
            Constants.bigCardPadding,
            Constants.bigCardPadding,
            2,
            Constants.bigCardPadding,
          ),
          onTap: onTap,
          title: title,
          titleTrailing: titleTrailing,
          subtitle: subtitle,
          child: child,
        ),
      ),
    );
  }
}

class SurfaceCard extends StatelessWidget {
  const SurfaceCard({
    super.key,
    required this.child,
    this.onTap,
    this.title = "",
    this.titleTrailing,
    this.subtitle = "",
    this.padding = const EdgeInsets.all(4),
  });

  final VoidCallback? onTap;
  final String title;
  final Widget? titleTrailing;
  final Widget child;
  final String subtitle;

  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final greyedOutColor = Theme.of(
      context,
    ).colorScheme.onPrimaryContainer.withAlpha(120);
    final chevronColor = Theme.of(
      context,
    ).colorScheme.onPrimaryContainer.withAlpha(50);

    return InkWell(
      enableFeedback: false,
      onTap: onTap,
      borderRadius: BorderRadius.circular(
        Theme.of(context).cardTheme.shape is RoundedRectangleBorder
            ? (Theme.of(context).cardTheme.shape as RoundedRectangleBorder)
                  .borderRadius
                  .resolve(TextDirection.ltr)
                  .topLeft
                  .x
            : 16.0,
      ),
      child: Card(
        elevation: 0,
        child: Padding(
          padding: padding,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (title.isNotEmpty)
                          Flexible(
                            child: Text(
                              title,
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(color: greyedOutColor),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        if (titleTrailing != null)
                          Flexible(child: titleTrailing!),
                      ],
                    ),
                    child,
                    if (subtitle.isNotEmpty) ...[
                      Text(
                        subtitle,
                        style: Theme.of(
                          context,
                        ).textTheme.bodySmall?.copyWith(color: greyedOutColor),
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
    );
  }
}
