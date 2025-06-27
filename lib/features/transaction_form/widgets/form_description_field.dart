import 'package:business_transactions/config/constants/string_const.dart';
import 'package:flutter/material.dart';

class FormDescriptionField extends StatelessWidget {
  final TextEditingController controller;

  const FormDescriptionField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: descriptionLabel,
        prefixIcon: Icon(Icons.description_outlined),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
      minLines: 1,
      maxLines: 4,
    );
  }
}
