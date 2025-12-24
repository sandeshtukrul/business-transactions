import 'package:business_transactions/config/constants/string_const.dart';
import 'package:flutter/material.dart';

class SplashBranding extends StatelessWidget {
  const SplashBranding({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    
    return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          appName, 
          style: textTheme.displayMedium?.copyWith(
            color: colorScheme.onPrimary,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          appTagline,
          style: textTheme.bodyMedium?.copyWith(
            color: colorScheme.onPrimary.withValues(alpha: 0.8),
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 48),
        SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(
            color: colorScheme.onPrimary, 
            strokeWidth: 2,
          ),
        ),
      ],
    )
    );
  }
}