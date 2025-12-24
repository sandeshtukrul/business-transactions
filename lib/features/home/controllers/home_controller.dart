import 'package:business_transactions/data/providers/repository_providers.dart';
import 'package:business_transactions/data/repositories/customer_repository.dart';
import 'package:business_transactions/features/home/states/home_state.dart';
import 'package:business_transactions/models/customer.dart';
import 'package:business_transactions/models/transaction.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_controller.g.dart';

/// Manages the state for the Home Screen (Dashboard).
/// Handles fetching customers, calculating total balance, and CRUD operations.
@riverpod
class HomeScreenController extends _$HomeScreenController {
  late final CustomerRepository _repository =
      ref.read(customerRepositoryProvider);


  /// Initialization: Fetches initial data, sorts it, and calculates the total balance.
  @override
  Future<HomeState> build() async {
    final customers = await _loadInitialData();

    // We sort customers by 'createdAt' (newest first) so the user sees recent activity.
    customers.sort((a, b) => b.createdAt.compareTo(a.createdAt));

    // Calculate total balance across all customers (Asset - Liability)
    final totalBalance =
        customers.fold<int>(0, (sum, c) => sum + c.currentBalance);

    return HomeState(
      customers: customers,
      totalBalance: totalBalance,
    );
  }

  // HELPER: Fetches raw data from the repository.
  Future<List<Customer>> _loadInitialData() async {
    List<Customer> customers = await _repository.fetchCustomers();
    return customers;
  }

  /// Adds new transaction to current customer.
  Future<void> addTransaction(String customerId, Transaction newTransaction) async {
    if (state.value == null) return;

    final originalList = state.value!.customers;
    final index = originalList.indexWhere((c) => c.id == customerId);

    if (index == -1) return; // Guard clause if customer not found

    final customer = originalList[index];
    final updatedCustomer = customer.copyWith(transactions: [...customer.transactions, newTransaction],
    );

    final newList = List<Customer>.from(originalList);
    newList[index] = updatedCustomer;
    _updateState(state.value!.copyWith(customers: newList));

    try {
      await _repository.saveCustomer(updatedCustomer);
    } catch (e) {
      _updateState(state.value!.copyWith(customers: originalList));
    }
  }


  /// Adds a new customer using Optimistic UI updates.
  Future<void> addCustomer(Customer newCustomer) async {

    // Guard clause: If data hasn't loaded yet, we can't add to it.
    if (state.value == null) return;

    // Snapshot the current state (in case we need to undo/rollback).
    final originalList = state.value!.customers;

    final newList = List<Customer>.from(originalList)..add(newCustomer);

    // 1. Update UI immediately
    _updateState(state.value!.copyWith(customers: newList));

    try {
      // 2. Persist to Database
      await _repository.saveCustomer(newCustomer);
    } catch (e) {
      // 3. Rollback on failure
      _updateState(state.value!.copyWith(customers: originalList));
    }
  }

  /// Updates an existing customer (e.g., renaming).
  Future<void> updateCustomer(Customer customerToUpdate) async {
    if (state.value == null) return;

    final originalList = state.value!.customers;
    final index = originalList.indexWhere((c) => c.id == customerToUpdate.id);

    if (index == -1) return;

    final newList = List<Customer>.from(originalList);
    newList[index] = customerToUpdate;

    _updateState(state.value!.copyWith(customers: newList));

    try {
      await _repository.saveCustomer(customerToUpdate);
    } catch (e) {
      // Rollback
      _updateState(state.value!.copyWith(customers: originalList));
    }
  }

  /// Deletes a customer and caches the deletion for "Undo" functionality.
  Future<void> deleteCustomer(Customer customerToDelete) async {
    if (state.value == null) return;

    final originalList = state.value!.customers;
    final originalIndex =
        originalList.indexWhere((c) => c.id == customerToDelete.id);

    if (originalIndex == -1) return;

    final newList = List<Customer>.from(originalList)..removeAt(originalIndex);

    // Update state and set 'lastDeleted' for the Undo Snackbar
    _updateState(state.value!.copyWith(
      customers: newList,
      lastDeleted: (customerToDelete, originalIndex),
    ));

    try {
      await _repository.removeCustomer(customerToDelete.id);
    } catch (e) {
      _updateState(state.value!.copyWith(
        customers: originalList,
        lastDeleted: null,
      ));
    }
  }

  /// Restores a deleted customer to their original position.
  Future<void> undoDeleteCustomer(
      Customer customerToRestore, int originalIndex) async {
    if (state.value == null) return;

    final newList = List<Customer>.from(state.value!.customers)
      ..insert(originalIndex, customerToRestore);

    _updateState(state.value!.copyWith(
      customers: newList,
      lastDeleted: null, // Clear the deleted flag
    ));

    try {
      await _repository.saveCustomer(customerToRestore);
    } catch (e) {
      _updateState(state.value!.copyWith(
        customers: newList,
        lastDeleted: null,
      ));
    }
  }

  /// Helper: Recalculates sort order and total balance whenever the list changes.
  void _updateState(HomeState newState) {
    if (state.value == null) return;

    final sortedCustomers = List<Customer>.from(newState.customers);
    sortedCustomers.sort((a, b) => b.createdAt.compareTo(a.createdAt));

    final newTotalBalance =
        sortedCustomers.fold(0, (sum, c) => sum + c.currentBalance);

    // We emit AsyncData to tell the UI: "Here is the new, valid data."
    state = AsyncData(newState.copyWith(
      customers: sortedCustomers,
      totalBalance: newTotalBalance,
    ));
  }

  /// Clears the Undo cache (called after Snackbar dismissal).
  void clearLastDeleted() {
    if (state.value == null || state.value!.lastDeleted == null) return;
    state = AsyncData(state.value!.copyWith(lastDeleted: null));
  }
}

// Simple provider for a username (Mock)
@riverpod
String? username(Ref ref) {
  return 'Sandesh';
}
