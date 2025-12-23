import 'package:flutter/material.dart';

/// Reusable header for form sections (Icon + Title).
class FormSectionHeader extends StatelessWidget {
  final IconData icon;
  final String title;

  const FormSectionHeader({super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      children: [
        Icon(icon, color: colorScheme.primary, size: 22),
        const SizedBox(width: 10),
        Text(title,
            style: textTheme.titleMedium?.copyWith(
                color: colorScheme.primary, fontWeight: FontWeight.bold)),
      ],
    );
  }
}
