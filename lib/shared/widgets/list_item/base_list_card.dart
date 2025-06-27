import 'package:flutter/material.dart';

class BaseListCard extends StatelessWidget {
  final void Function(LongPressStartDetails)? onLongPress;
  final Widget child;

  const BaseListCard({super.key, this.onLongPress, required this.child});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            colorScheme.primary.withValues(alpha: 0.1),
            colorScheme.surface.withValues(alpha: 0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colorScheme.outline),
      ),
      child: GestureDetector(
        onLongPressStart: onLongPress,
        child: child,
      ), // The actual content (e.g., ListTile) goes here
    );
  }
}
