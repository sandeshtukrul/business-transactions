import 'package:business_transactions/config/app_text_styles.dart';
import 'package:business_transactions/config/glass_theme.dart';
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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colorScheme = Theme.of(context).colorScheme;

    return AppBar(
      // Custom Back Button Logic (Defaults to Navigator.pop if not provided)
      leading: IconButton(
        icon: Icon(Icons.arrow_back,color: isDark ? Colors.white : GlassColors.textDark),
        onPressed: onBack ?? () => Navigator.of(context).pop(),
      ),
      title: Text(title, style: AppTextStyles.sectionHeader.copyWith(color: isDark ? Colors.white : GlassColors.textDark,)),

      // Styling to match the app's primary theme
      backgroundColor: Colors.transparent,
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
