import 'package:business_transactions/core/utils/formatters.dart';
import 'package:business_transactions/features/transaction_form/state/transaction_form_state.dart';
import 'package:business_transactions/models/customer.dart';
import 'package:business_transactions/models/transaction.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'transaction_form_controller.g.dart';

/// Manages the state and logic for the Transaction Form.
/// Handles initialization (mode detection) and form submission.
@riverpod
class TransactionFormController extends _$TransactionFormController {

  /// Initialization Logic:
  /// Automatically detects the [FormMode] based on the arguments passed.
  @override
  TransactionFormState build({Customer? customer, Transaction? transaction}) {
    FormMode mode;
    if (transaction != null) {
      mode = FormMode.updateTransaction;
    } else if (customer != null) {
      mode = FormMode.addTransaction;
    } else {
      mode = FormMode.addCustomer;
    }

    // Pre-fill state if editing
    return TransactionFormState(
      mode: mode,
      initialCustomer: customer,
      initialTransaction: transaction,
      transactionType: transaction?.type ?? TransactionType.sent,
      selectedPaymentMethod: transaction?.paymentMethod,
      selectedDateTime: transaction?.createdAt ?? DateTime.now(),
    );
  }

  // --- Field Updaters ---

  void setTransactionType(TransactionType type) {
    state = state.copyWith(transactionType: type);
  }

  void setPaymentMethod(String? method) {
    state = state.copyWith(selectedPaymentMethod: method);
  }

  void setDateTime(DateTime dateTime) {
    state = state.copyWith(selectedDateTime: dateTime);
  }

  /// Processes the form submission.
  /// Instead of saving to the database directly, it creates the object (Customer or Transaction)
  /// and returns it to the calling screen. This keeps the form reusable and decoupled.
  Future<void> submitForm({
    required String customerName,
    required String partyName,
    required String amount,
    String? description,
  }) async {
    state = state.copyWith(status: FormStatus.submitting);

    try {
      Object? result;

      // Polymorphic creation logic based on mode
      switch (state.mode) {
        case FormMode.addCustomer:
          final newTransaction = Transaction(
            partyName: partyName.trim(),
            description: description?.trim(),
            amount: Formatters.parseAmountStringToPaisa(amount),
            paymentMethod: state.selectedPaymentMethod!,
            type: state.transactionType,
            createdAt: state.selectedDateTime,
          );
          // Return new Customer with the initial transaction
          result = Customer(
              name: customerName.trim(), transactions: [newTransaction]);
          break;

        case FormMode.addTransaction:
          // Return just the new Transaction
          result = Transaction(
            partyName: partyName.trim(),
            description: description?.trim(),
            amount: Formatters.parseAmountStringToPaisa(amount),
            paymentMethod: state.selectedPaymentMethod!,
            type: state.transactionType,
            createdAt: state.selectedDateTime,
          );
          break;

        case FormMode.updateTransaction:
          // Return the updated Transaction (using copyWith)
          result = state.initialTransaction!.copyWith(
            partyName: partyName.trim(),
            description: description?.trim(),
            amount: Formatters.parseAmountStringToPaisa(amount),
            paymentMethod: state.selectedPaymentMethod!,
            type: state.transactionType,
            createdAt: state.selectedDateTime,
          );
          break;
      }

      // We don't save to the repository here. We pop with the result,
      // Success: Calling screen will handle the actual DB save/update.
      state = state.copyWith(status: FormStatus.success, result: result);
    } catch (e) {
      state =
          state.copyWith(status: FormStatus.error, errorMessage: e.toString());
    }
  }
}
