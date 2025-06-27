import 'package:business_transactions/shared/widgets/list_item/leading_circle.dart';
import 'package:flutter/material.dart';

class ListTileContent extends StatelessWidget {
  final String title;
  final Widget trailing;
  final Widget subtitle;
  final VoidCallback onTap;

  const ListTileContent({
    super.key,
    required this.title,
    required this.trailing,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      leading: LeadingCircle(label: title),
      title: Text(
        title,
        style: textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: subtitle,
      trailing: trailing,
      onTap: onTap,
    );
  }
}
