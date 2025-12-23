import 'package:business_transactions/core/utils/validators.dart';
import 'package:flutter/material.dart';

/// A versatile text field that can switch between "Input Mode" and "Display Mode".
/// Used for displaying the Customer Name (Read-only) when adding a transaction.
class FormTitleField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final IconData icon;
  final bool isReadOnly;

  const FormTitleField(
      {super.key,
      required this.controller,
      required this.labelText,
      required this.icon,
      this.isReadOnly = false});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          prefixIcon: Icon(icon),
          enabled: !isReadOnly),
      readOnly: isReadOnly,
      validator: (value) => validateRequiredField(value, labelText),
    );
  }
}
