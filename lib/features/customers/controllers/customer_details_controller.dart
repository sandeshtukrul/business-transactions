import 'package:business_transactions/data/providers/repository_providers.dart';
import 'package:business_transactions/features/customers/states/customer_details_state.dart';
import 'package:business_transactions/models/transaction.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:business_transactions/config/constants/string_const.dart';

part 'customer_details_controller.g.dart';


/// Manages the state for the Customer Details Screen.
/// Handles CRUD operations for transactions and syncs with the Repository.
@riverpod
class CustomerDetailsController extends _$CustomerDetailsController {

  /// Initialization: Fetches the specific customer by ID.
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

  /// Adds a new transaction and updates the local state immediately (Optimistic UI).
  Future<void> addTransaction(Transaction newTransaction) async {
    final currentState = state.valueOrNull;
    if (currentState == null || currentState.customer == null) return;

    // Create a new Customer object with the transaction added (Immutability).
    final updatedCustomer = currentState.customer!.copyWith(
      transactions: [...currentState.customer!.transactions, newTransaction],
    );

    await _updateState(currentState.copyWith(customer: updatedCustomer));
  }

  /// Updates an existing transaction by matching its ID.
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

  /// Deletes a transaction but caches it in 'lastDeletedTransaction' for Undo capability.
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

    // Update state and store deleted item info for potential restore.
    await _updateState(currentState.copyWith(
      customer: updatedCustomer,
      lastDeletedTransaction: (transactionToDelete, originalIndex),
    ));
  }

  /// Restores the last deleted transaction to its original index.
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

  /// Clears the undo cache (called when the Undo Snackbar is dismissed/timeout).
  void clearLastDeleted() {
    if (state.value == null || state.value!.lastDeletedTransaction == null) {
      return;
    }
    state = AsyncData(state.value!.copyWith(lastDeletedTransaction: null));
  }

  /// Helper: Updates local state and persists changes to the Repository.
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
