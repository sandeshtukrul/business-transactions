import 'package:business_transactions/config/glass_theme.dart';
import 'package:flutter/material.dart';

// --- 1. DIALOG SHELL ---
class GlassDialogShell extends StatelessWidget {
  final String title;
  final Widget child;

  const GlassDialogShell({super.key, required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    return Dialog(
      backgroundColor: theme.colorScheme.surface,
      surfaceTintColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 400),
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: isDark ? GlassColors.textLight : GlassColors.textDark)),
                  IconButton(
                    icon: Icon(Icons.close, color: GlassColors.textSubtle),
                    onPressed: () => Navigator.pop(context),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              // Body
              child,
            ],
          ),
        ),
      ),
    );
  }
}

// --- 2. DIALOG TEXT FIELD ---
class GlassDialogTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? hint;
  final bool isRequired;
  final bool autoFocus;
  final TextCapitalization textCapitalization;

  const GlassDialogTextField({
    super.key,
    required this.controller,
    required this.label,
    this.hint,
    this.isRequired = false,
    this.autoFocus = false,
    this.textCapitalization = TextCapitalization.sentences,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final subTextColor = GlassColors.textSubtle;
    final inputFill = isDark ? Colors.black12 : Colors.grey.shade50;
    
    final inputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: isDark ? Colors.white12 : Colors.black12),
    );

    return TextFormField(
      controller: controller,
      style: TextStyle(color: isDark ? GlassColors.textLight : GlassColors.textDark),
      textCapitalization: textCapitalization,
      autofocus: autoFocus,
      decoration: InputDecoration(
        labelText: isRequired ? "$label (Required)" : "$label (Optional)",
        hintText: hint,
        labelStyle: TextStyle(color: subTextColor),
        filled: true,
        fillColor: inputFill,
        border: inputBorder,
        enabledBorder: inputBorder,
      ),
      validator: isRequired 
          ? (val) => val == null || val.trim().isEmpty ? "$label is required" : null
          : null,
    );
  }
}

// --- 3. DIALOG SAVE BUTTON ---
class GlassDialogButton extends StatelessWidget {
  final String label;
  final bool isLoading;
  final VoidCallback? onPressed;

  const GlassDialogButton({
    super.key,
    required this.label,
    required this.isLoading,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        child: isLoading
            ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
            : Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ),
    );
  }
}