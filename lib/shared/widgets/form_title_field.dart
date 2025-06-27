import 'package:business_transactions/core/utils/validators.dart';
import 'package:flutter/material.dart';

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
