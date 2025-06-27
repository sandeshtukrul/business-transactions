import 'package:business_transactions/config/constants/string_const.dart';
import 'package:business_transactions/models/customer.dart';
import 'package:hive/hive.dart';

class CustomerLocalDataSource {
  static final CustomerLocalDataSource instance = CustomerLocalDataSource._();
  static const String boxName = customersBox;

  Box<Customer>? _box; // Keep a reference to the opened box

  bool _initialized = false;

  // Private constructor for potential singleton or controlled instantiation
  CustomerLocalDataSource._();

  Future<void> init() async {
    if (_initialized) return;
    _box = await Hive.openBox<Customer>(boxName);
    _initialized = true;
  }

  Future<List<Customer>> getAllCustomers() async {
    try {
      _ensureInitialized();
      return _box!.values.toList();
    } catch (e) {
      throw Exception('$couldNotFetchCustomersException$colon $e');
    }
  }

  Future<void> addOrUpdateCustomer(Customer customer) async {
    try {
      _ensureInitialized();
      await _box!.put(customer.id, customer);
    } catch (e) {
      throw Exception(
          '$couldNotSaveCustomerException ${customer.name}$colon $e');
    }
  }

  Future<void> deleteCustomer(String customerId) async {
    try {
      _ensureInitialized();
      await _box!.delete(customerId);
    } catch (e) {
      throw Exception('$couldNotDeleteCustomerException($customerId)$colon $e');
    }
  }

  Future<void> close() async {
    if (_box?.isOpen ?? false) {
      await _box!.close();
      _initialized = false;
      _box = null;
    }
  }

  Future<Customer?> getCustomerById(String customerId) async {
    try {
      _ensureInitialized();
      return _box!.get(customerId);
    } catch (e) {
      throw Exception(
          '$couldNotFetchCustomerByIdException ($customerId)$colon $e');
    }
  }

  void _ensureInitialized() {
    if (!_box!.isOpen || !_initialized || _box == null) {
      throw Exception(dataSourceNotInitializedException);
    }
  }
}
