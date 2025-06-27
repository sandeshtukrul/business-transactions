import 'package:business_transactions/data/providers/repository_providers.dart';
import 'package:business_transactions/features/customers/states/customer_details_state.dart';
import 'package:business_transactions/models/transaction.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:business_transactions/config/constants/string_const.dart';

part 'customer_details_controller.g.dart';

@riverpod
class CustomerDetailsController extends _$CustomerDetailsController {
  @override
  Future<CustomerDetailsState> build(String customerId) async {
    final customer = await ref
        .read(customerRepositoryProvider)
        .fetchCustomerById(customerId);

    if (customer == null) {
      throw Exception(customerNotFoundException);
    }
    return CustomerDetailsState(customer: customer);
  }

  Future<void> addTransaction(Transaction newTransaction) async {
    final currentState = state.valueOrNull;
    if (currentState == null || currentState.customer == null) return;

    final updatedCustomer = currentState.customer!.copyWith(
      transactions: [...currentState.customer!.transactions, newTransaction],
    );

    await _updateState(currentState.copyWith(customer: updatedCustomer));
  }

  Future<void> updateTransaction(Transaction transactionToUpdate) async {
    final currentState = state.valueOrNull;
    if (currentState == null || currentState.customer == null) return;

    final updatedTransactions = currentState.customer!.transactions.map((t) {
      return t.id == transactionToUpdate.id ? transactionToUpdate : t;
    }).toList();

    final updatedCustomer =
        currentState.customer!.copyWith(transactions: updatedTransactions);

    await _updateState(currentState.copyWith(customer: updatedCustomer));
  }

  Future<void> deleteTransaciton(Transaction transactionToDelete) async {
    final currentState = state.valueOrNull;
    if (currentState?.customer == null) return;

    final originalIndex = currentState!.customer!.transactions
        .indexWhere((t) => t.id == transactionToDelete.id);

    if (originalIndex == -1) return;

    final updatedTransactions =
        List<Transaction>.from(currentState.customer!.transactions)
          ..removeWhere((t) => t.id == transactionToDelete.id);

    final updatedCustomer =
        currentState.customer!.copyWith(transactions: updatedTransactions);

    await _updateState(currentState.copyWith(
      customer: updatedCustomer,
      lastDeletedTransaction: (transactionToDelete, originalIndex),
    ));
  }

  Future<void> undoDeleteTransaction() async {
    final currentState = state.valueOrNull;
    final lastDeletedTransaction = currentState?.lastDeletedTransaction;
    if (lastDeletedTransaction == null || currentState?.customer == null) {
      return;
    }

    final (transactionToRestore, originalIndex) = lastDeletedTransaction;

    final restoredTransactions =
        List<Transaction>.from(currentState!.customer!.transactions)
          ..insert(originalIndex, transactionToRestore);

    final customerAfterRestore =
        currentState.customer!.copyWith(transactions: restoredTransactions);

    await _updateState(currentState.copyWith(
      customer: customerAfterRestore,
      lastDeletedTransaction: null,
    ));
  }

  /// This method will be call when trnasaction is deleted and user has no option to undo.
  void clearLastDeleted() {
    if (state.value == null || state.value!.lastDeletedTransaction == null) {
      return;
    }
    // Update state by just clearing the lastDeleted property
    state = AsyncData(state.value!.copyWith(lastDeletedTransaction: null));
  }

  Future<void> _updateState(CustomerDetailsState newState) async {
    final previousState = state;

    state = AsyncData(newState);

    try {
      await ref
          .read(customerRepositoryProvider)
          .saveCustomer(newState.customer!);
    } catch (e) {
      state = previousState;
    }
  }
}
