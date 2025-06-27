import 'package:business_transactions/data/providers/repository_providers.dart';
import 'package:business_transactions/data/repositories/customer_repository.dart';
import 'package:business_transactions/features/home/states/home_state.dart';
import 'package:business_transactions/models/customer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_controller.g.dart';

@riverpod
class HomeScreenController extends _$HomeScreenController {
  late final CustomerRepository _repository =
      ref.read(customerRepositoryProvider);

  @override
  Future<HomeState> build() async {
    final customers = await _loadInitialData();
    customers.sort((a, b) => b.createdAt.compareTo(a.createdAt));

    final totalBalance =
        customers.fold<int>(0, (sum, c) => sum + c.currentBalance);

    return HomeState(
      customers: customers,
      totalBalance: totalBalance,
    );
  }

  Future<List<Customer>> _loadInitialData() async {
    List<Customer> customers = await _repository.fetchCustomers();
    return customers;
  }

  Future<void> addCustomer(Customer newCustomer) async {
    if (state.value == null) return;

    final originalList = state.value!.customers;
    final newList = List<Customer>.from(originalList)..add(newCustomer);

    _updateState(state.value!.copyWith(customers: newList));

    try {
      await _repository.saveCustomer(newCustomer);
    } catch (e) {
      _updateState(state.value!.copyWith(customers: originalList));
    }
  }

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
      _updateState(state.value!.copyWith(customers: originalList));
    }
  }

  Future<void> deleteCustomer(Customer customerToDelete) async {
    if (state.value == null) return;

    final originalList = state.value!.customers;
    final originalIndex =
        originalList.indexWhere((c) => c.id == customerToDelete.id);

    if (originalIndex == -1) return;

    final newList = List<Customer>.from(originalList)..removeAt(originalIndex);

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

  Future<void> undoDeleteCustomer(
      Customer customerToRestore, int originalIndex) async {
    if (state.value == null) return;

    final newList = List<Customer>.from(state.value!.customers)
      ..insert(originalIndex, customerToRestore);

    _updateState(state.value!.copyWith(
      customers: newList,
      lastDeleted: null,
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

  void _updateState(HomeState newState) {
    if (state.value == null) return;

    final sortedCustomers = List<Customer>.from(newState.customers);
    sortedCustomers.sort((a, b) => b.createdAt.compareTo(a.createdAt));

    final newTotalBalance =
        sortedCustomers.fold(0, (sum, c) => sum + c.currentBalance);

    state = AsyncData(newState.copyWith(
      customers: sortedCustomers,
      totalBalance: newTotalBalance,
    ));
  }

  void clearLastDeleted() {
    if (state.value == null || state.value!.lastDeleted == null) return;
    // Update state by just clearing the lastDeleted property
    state = AsyncData(state.value!.copyWith(lastDeleted: null));
  }
}

@riverpod
String? username(Ref ref) {
  return 'Sandesh';
}
