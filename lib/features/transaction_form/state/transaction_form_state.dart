import 'package:business_transactions/config/constants/string_const.dart';
import 'package:business_transactions/models/customer.dart';
import 'package:business_transactions/models/transaction.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'transaction_form_state.freezed.dart';

enum FormMode { addCustomer, addTransaction, updateTransaction }

enum FormStatus { initial, submitting, success, error }

@freezed
class TransactionFormState with _$TransactionFormState {
  const factory TransactionFormState({
    // Determines what fields are shown and what happens on save
    required FormMode mode,
    // Tracks submission state to show loading indicators on the save button
    @Default(FormStatus.initial) FormStatus status,
    // Initial data passed to the form
    Customer? initialCustomer,
    Transaction? initialTransaction,
    // Form fields' state
    @Default(TransactionType.sent) TransactionType transactionType,
    String? selectedPaymentMethod,
    DateTime? selectedDateTime,
    // Holds the final result to be popped back
    Object? result,
    String? errorMessage,
  }) = _TransactionFormState;
}

extension TransactionFromStateX on TransactionFormState {
  String get appBarTitle {
    switch (mode) {
      case FormMode.addCustomer:
        return addCustomerAppbarTitle;

      case FormMode.addTransaction:
        return addTransactionAppbarTitle;

      case FormMode.updateTransaction:
        return updateTransactionAppbarTitle;
    }
  }
}
