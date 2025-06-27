import 'package:business_transactions/config/constants/string_const.dart';
import 'package:flutter/material.dart';

class FormSaveButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const FormSaveButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return ElevatedButton.icon(
      icon: Icon(
        Icons.save_alt_outlined,
        color: colorScheme.onPrimary,
      ),
      label: const Text(completeAndSaveButton),
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 14),
        textStyle: textTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
      ),
    );
  }
}
