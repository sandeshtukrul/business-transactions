import 'package:business_transactions/core/utils/formatters.dart';
import 'package:business_transactions/features/transaction_form/state/transaction_form_state.dart';
import 'package:business_transactions/models/customer.dart';
import 'package:business_transactions/models/transaction.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'transaction_form_controller.g.dart';

@riverpod
class TransactionFormController extends _$TransactionFormController {
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

    return TransactionFormState(
      mode: mode,
      initialCustomer: customer,
      initialTransaction: transaction,
      transactionType: transaction?.type ?? TransactionType.sent,
      selectedPaymentMethod: transaction?.paymentMethod,
      selectedDateTime: transaction?.createdAt ?? DateTime.now(),
    );
  }

  void setTransactionType(TransactionType type) {
    state = state.copyWith(transactionType: type);
  }

  void setPaymentMethod(String? method) {
    state = state.copyWith(selectedPaymentMethod: method);
  }

  void setDateTime(DateTime dateTime) {
    state = state.copyWith(selectedDateTime: dateTime);
  }

  Future<void> submitForm({
    required String customerName,
    required String partyName,
    required String amount,
    String? description,
  }) async {
    state = state.copyWith(status: FormStatus.submitting);

    try {
      Object? result;

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
          result = Customer(
              name: customerName.trim(), transactions: [newTransaction]);
          break;

        case FormMode.addTransaction:
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
      // and let the *calling screen's controller* handle persistence.
      // This keeps responsibilities separate.
      state = state.copyWith(status: FormStatus.success, result: result);
    } catch (e) {
      state =
          state.copyWith(status: FormStatus.error, errorMessage: e.toString());
    }
  }
}
