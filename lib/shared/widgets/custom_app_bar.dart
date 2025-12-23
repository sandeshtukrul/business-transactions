import 'package:flutter/material.dart';

/// A consistent AppBar component used throughout the app (except Home).
/// Implements [PreferredSizeWidget] to define its height for the Scaffold.
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBack;

  const CustomAppBar({
    super.key,
    required this.title,
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return AppBar(
      // Custom Back Button Logic (Defaults to Navigator.pop if not provided)
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: onBack ?? () => Navigator.of(context).pop(),
      ),
      title: Text(title),

      // Styling to match the app's primary theme
      iconTheme: IconThemeData(color: colorScheme.onPrimary),
      backgroundColor: colorScheme.primary,
      centerTitle: true,
      titleTextStyle: textTheme.titleLarge?.copyWith(
        color: colorScheme.onPrimary,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
