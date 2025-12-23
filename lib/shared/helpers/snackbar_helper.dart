import 'package:business_transactions/config/constants/string_const.dart';
import 'package:flutter/material.dart';

/// Helper for displaying standard SnackBar notifications.
/// Provides consistent styling for Success, Error, and Info messages.
class SnackbarHelper {

  /// Shows a general success message (e.g., "Saved Successfully").
  static void showSuccess(BuildContext context, String message,
      {Duration? duration,
      VoidCallback? onAction,
      String actionLable = undoButton}) {
    _showWithType(context, message, duration, onAction, actionLable);
  }

  /// Shows an error message (e.g., "Database Failed").
  static void showError(BuildContext context, String message,
      {Duration? duration,
      VoidCallback? onAction,
      String actionLable = retryButton}) {
    _showWithType(context, message, duration, onAction, actionLable);
  }

  /// Shows an informational message.
  static void showInfo(BuildContext context, String message,
      {Duration? duration,
      VoidCallback? onAction,
      String actionLable = dismissButton}) {
    _showWithType(context, message, duration, onAction, actionLable);
  }

  /// Internal implementation to display the SnackBar using [ScaffoldMessenger].
  static void _showWithType(
    BuildContext context,
    String message,
    Duration? duration,
    VoidCallback? onAction,
    String actionLabel,
  ) {
    final messenger = ScaffoldMessenger.maybeOf(context);

    // Safety check: Ensure the context is valid before trying to show UI.
    if (messenger == null) return;

    messenger.showSnackBar(SnackBar(
      content: Text(message),
      behavior: SnackBarBehavior.floating,  // Floats above FABs/BottomBars
      duration: duration ?? const Duration(seconds: 4),
      action: onAction != null
          ? SnackBarAction(
              label: actionLabel,
              onPressed: onAction,
            )
          : null,
    ));
  }
}
