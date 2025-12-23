import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

/// A generic widget for Empty States (No Customers, No Transactions).
/// Uses Lottie animations to provide a delightful user experience.
class EmptyView extends StatelessWidget {
  final String lottiePath;
  final String title;
  final String subtitle;
  final bool repeatable;

  const EmptyView({
    super.key,
    required this.lottiePath,
    required this.title,
    required this.subtitle,
    this.repeatable = false,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              lottiePath,
              width: 250,
              height: 250,
              repeat: repeatable,
            ),
            Text(
              title,
              style: textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              style: textTheme.bodyLarge?.copyWith(
                  color: colorScheme.onSurfaceVariant.withValues(alpha: 0.5)),
            ),
          ],
        ),
      ),
    );
  }
}
