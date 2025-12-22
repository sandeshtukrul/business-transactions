import 'package:business_transactions/data/providers/repository_providers.dart';
import 'package:business_transactions/data/repositories/customer_repository.dart';
import 'package:business_transactions/features/home/states/home_state.dart';
import 'package:business_transactions/models/customer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_controller.g.dart';

// CONTROLLER (The Manager):
// This class handles all "Business Logic" for the Home Screen.
// The UI (View) should never talk to the Database directly; it must go through here.
// We use [AsyncNotifier] because our state loads asynchronously (from the DB).
@riverpod
class HomeScreenController extends _$HomeScreenController {


  // DEPENDENCY INJECTION:
  // We don't create a "new Repository()" here. We ask Riverpod to give us one.
  // This makes the code modular and easier to test.
  // This decoupling allows us to easily swap the repository (e.g., for testing).
  late final CustomerRepository _repository =
      ref.read(customerRepositoryProvider);


  // BUILD METHOD:
  // This is the starting point. When the screen loads, this function runs.
  // It fetches the initial data from Hive and prepares the state. (Loading, Error, or Data).
  @override
  Future<HomeState> build() async {
    final customers = await _loadInitialData();

    // SORTING LOGIC:
    // We sort customers by 'createdAt' (newest first) so the user sees recent activity.
    customers.sort((a, b) => b.createdAt.compareTo(a.createdAt));

    // AGGREGATION LOGIC:
    // We calculate the total balance dynamically.
    // This ensures the "Dashboard" balance is always in sync with the list.
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


  // OPTIMISTIC UPDATE PATTERN:
  // This is a professional trick to make the app feel faster.
  // Instead of waiting for the Database to finish saving (which takes milliseconds),
  // we update the UI *instantly*. This makes the app feel incredibly fast.
  Future<void> addCustomer(Customer newCustomer) async {

    // 1. Guard clause: If data hasn't loaded yet, we can't add to it.
    if (state.value == null) return;

    // 2. Snapshot the current state (in case we need to undo/rollback).
    final originalList = state.value!.customers;

    // 3. Update UI IMMEDIATELY (Optimistic):
    // We create a new list with the new customer added.
    final newList = List<Customer>.from(originalList)..add(newCustomer);
    _updateState(state.value!.copyWith(customers: newList));

    // 4. Perform the actual Database write in the background.
    try {
      await _repository.saveCustomer(newCustomer);
    } catch (e) {
      // 5. ROLLBACK ON ERROR:
      // If the DB fails, we revert the UI to 'originalList' so the user knows it failed.
      _updateState(state.value!.copyWith(customers: originalList));
    }
  }

  Future<void> updateCustomer(Customer customerToUpdate) async {
    if (state.value == null) return;

    final originalList = state.value!.customers;
    final index = originalList.indexWhere((c) => c.id == customerToUpdate.id);

    if (index == -1) return;

    // Optimistic Update
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

  // DELETE WITH UNDO SUPPORT:
  // We track 'lastDeleted' in the state so the UI can show a Snackbar.
  Future<void> deleteCustomer(Customer customerToDelete) async {
    if (state.value == null) return;

    final originalList = state.value!.customers;
    final originalIndex =
        originalList.indexWhere((c) => c.id == customerToDelete.id);

    if (originalIndex == -1) return;

    // Remove locally first
    final newList = List<Customer>.from(originalList)..removeAt(originalIndex);

    // Update state AND set the 'lastDeleted' property.
    // The UI listens to 'lastDeleted' to trigger the "Undo" Snackbar.
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


  // UNDO FUNCTIONALITY:
  // Called when the user taps "Undo" on the Snackbar.
  Future<void> undoDeleteCustomer(
      Customer customerToRestore, int originalIndex) async {
    if (state.value == null) return;

    // Re-insert the customer at their exact previous position.
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

  // STATE RECALCULATION:
  // Whenever the list changes, we must re-sort and re-calculate the total balance.
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

  // Clears the "Undo" memory so the Snackbar doesn't trigger again inappropriately.
  void clearLastDeleted() {
    if (state.value == null || state.value!.lastDeleted == null) return;
    state = AsyncData(state.value!.copyWith(lastDeleted: null));
  }
}

// Simple provider for a username (Mock data for now)
@riverpod
String? username(Ref ref) {
  return 'Sandesh';
}
