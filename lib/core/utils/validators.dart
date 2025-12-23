import 'package:business_transactions/config/constants/string_const.dart';

/// Validates standard required text fields.
/// Returns error message if null or empty, otherwise null.
String? validateRequiredField(String? value, String label) {
  if (value == null || value.trim().isEmpty) {
    return '$enterNameError $label';
  }
  return null;
}


/// Validates currency input fields.
/// Ensures input is a positive number and handles incomplete states (e.g., "10.").
String? validateAmount(String? value) {
  if (value == null || value.trim().isEmpty) {
    return enterAmountError;
  }
  final amount = double.tryParse(value.trim());

  // Validation Rules:
  // 1. Must be a parsable number.
  // 2. Must be greater than 0.
  // 3. Should not end with '.' (Prevents error while user is typing decimals).
  if (amount == null || amount <= 0 || value.endsWith('.')) {
    return validAmountError;
  }
  return null;
}

/// Validates that a dropdown option has been selected.
String? validatePaymentMethod(String? value) {
  if (value == null || value.trim().isEmpty) {
    return selectPaymentMethodError;
  }
  return null;
}
