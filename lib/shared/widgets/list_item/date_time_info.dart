import 'package:flutter/material.dart';

class DateTimeInfo extends StatelessWidget {
  final String dateTimeText;
  final IconData? icon;

  const DateTimeInfo(
      {super.key, required this.dateTimeText, this.icon = Icons.schedule});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon,
            size: 14,
            color: colorScheme.onSurfaceVariant.withValues(alpha: 0.8)),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            dateTimeText,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: textTheme.bodySmall!.copyWith(
              color: colorScheme.onSurfaceVariant.withValues(alpha: 0.8),
            ),
          ),
        ),
      ],
    );
  }
}
