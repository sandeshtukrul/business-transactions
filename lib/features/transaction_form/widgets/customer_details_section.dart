import 'package:business_transactions/config/constants/string_const.dart';
import 'package:business_transactions/features/transaction_form/widgets/form_section.dart';
import 'package:business_transactions/shared/widgets/form_title_field.dart';
import 'package:flutter/material.dart';

class CustomerDetailsSection extends StatelessWidget {
  final bool? isReadOnly;
  final TextEditingController controller;

  const CustomerDetailsSection(
      {super.key, this.isReadOnly = false, required this.controller});

  @override
  Widget build(BuildContext context) {
    return FormSection(
        title: customerDetailsHeader,
        icon: Icons.person_pin_outlined,
        children: [
          FormTitleField(
            controller: controller,
            labelText: customerNameLabel,
            icon: Icons.person,
            isReadOnly: isReadOnly!,
          )
        ]);
  }
}
