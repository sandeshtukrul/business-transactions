import 'package:business_transactions/config/constants/string_const.dart';
import 'package:flutter/material.dart';

class LeadingCircle extends StatelessWidget {
  final String label;

  const LeadingCircle({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: colorScheme.outline, width: 0.5),
      ),
      child: CircleAvatar(
        backgroundColor: colorScheme.primaryContainer,
        foregroundColor: colorScheme.onPrimaryContainer,
        child: Text(
          label.isNotEmpty ? label.trim()[0].toUpperCase() : questionMark,
        ),
      ),
    );
  }
}
