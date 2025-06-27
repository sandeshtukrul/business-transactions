import 'package:business_transactions/config/constants/string_const.dart';
import 'package:business_transactions/core/utils/validators.dart';
import 'package:flutter/material.dart';

class PaymentMethodDropdown extends StatelessWidget {
  final String? selectedPaymentMethod;
  final ValueChanged<String?> onChanged;
  final List<String> paymentMethods;

  const PaymentMethodDropdown({
    super.key,
    this.selectedPaymentMethod,
    required this.onChanged,
    required this.paymentMethods,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: paymentMethodLabel,
        prefixIcon: Icon(Icons.payment_outlined),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
      ),
      value: selectedPaymentMethod,
      hint: const Text(selectMethodHint),
      isExpanded: true, // Background of dropdown menu
      onChanged: onChanged,
      items: paymentMethods.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      validator: validatePaymentMethod,
    );
  }
}
