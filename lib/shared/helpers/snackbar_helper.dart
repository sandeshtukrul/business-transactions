import 'package:business_transactions/config/constants/string_const.dart';
import 'package:flutter/material.dart';

class SnackbarHelper {
  static void showSuccess(BuildContext context, String message,
      {Duration? duration,
      VoidCallback? onAction,
      String actionLable = undoButton}) {
    _showWithType(context, message, duration, onAction, actionLable);
  }

  static void showError(BuildContext context, String message,
      {Duration? duration,
      VoidCallback? onAction,
      String actionLable = retryButton}) {
    _showWithType(context, message, duration, onAction, actionLable);
  }

  static void showInfo(BuildContext context, String message,
      {Duration? duration,
      VoidCallback? onAction,
      String actionLable = dismissButton}) {
    _showWithType(context, message, duration, onAction, actionLable);
  }

  static void _showWithType(
    BuildContext context,
    String message,
    Duration? duration,
    VoidCallback? onAction,
    String actionLabel,
  ) {
    final messenger = ScaffoldMessenger.maybeOf(context);

    if (messenger == null) return;

    messenger.showSnackBar(SnackBar(
      content: Text(message),
      behavior: SnackBarBehavior.floating,
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
