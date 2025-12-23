import 'package:business_transactions/config/constants/string_const.dart';
import 'package:business_transactions/core/utils/validators.dart';
import 'package:flutter/material.dart';

/// Dropdown menu for selecting Payment Methods (Cash, UPI, etc.).
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
      initialValue: selectedPaymentMethod,
      hint: const Text(selectMethodHint),
      isExpanded: true, // Ensures the dropdown takes full width
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
