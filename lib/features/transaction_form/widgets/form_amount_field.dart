import 'package:business_transactions/config/constants/string_const.dart';
import 'package:business_transactions/core/utils/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FormAmountField extends StatelessWidget {
  final TextEditingController controller;

  const FormAmountField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: amountLabel,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
        prefixIcon: Icon(Icons.currency_rupee_sharp),
      ),
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'^\d*(\.\d{0,2})?$')),
      ],
      validator: validateAmount,
    );
  }
}
