import 'package:business_transactions/config/constants/string_const.dart';
import 'package:business_transactions/models/customer.dart';
import 'package:business_transactions/models/transaction.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'transaction_form_state.freezed.dart';

/// Defines the operational mode of the form.
/// 1. [addCustomer]: Creating a new customer + initial transaction.
/// 2. [addTransaction]: Adding a transaction to an existing customer.
/// 3. [updateTransaction]: Editing an existing transaction.
enum FormMode { addCustomer, addTransaction, updateTransaction }

enum FormStatus { initial, submitting, success, error }

/// Immutable state holding all form data and UI status.
@freezed
class TransactionFormState with _$TransactionFormState {
  const factory TransactionFormState({

    // Determines what fields are shown and what happens on save
    required FormMode mode,

    // Tracks submission state to show loading indicators on the save button
    @Default(FormStatus.initial) FormStatus status,

    // Initial data for Edit mode
    Customer? initialCustomer,
    Transaction? initialTransaction,

    // Form Fields Values
    @Default(TransactionType.sent) TransactionType transactionType,
    String? selectedPaymentMethod,
    DateTime? selectedDateTime,
    
    // The created/updated object returned to the previous screen
    Object? result,
    String? errorMessage,
  }) = _TransactionFormState;
}


/// Helper extension to determine the AppBar title dynamically.
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
