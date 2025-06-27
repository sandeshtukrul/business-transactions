import 'package:business_transactions/config/constants/string_const.dart';

String? validateRequiredField(String? value, String label) {
  if (value == null || value.trim().isEmpty) {
    return '$enterNameError $label';
  }
  return null;
}

String? validateAmount(String? value) {
  if (value == null || value.trim().isEmpty) {
    return enterAmountError;
  }
  final amount = double.tryParse(value.trim());
  if (amount == null || amount <= 0 || value.endsWith('.')) {
    return validAmountError;
  }
  return null;
}

String? validatePaymentMethod(String? value) {
  if (value == null || value.trim().isEmpty) {
    return selectPaymentMethodError;
  }
  return null;
}
