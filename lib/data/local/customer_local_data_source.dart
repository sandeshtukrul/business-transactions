import 'package:business_transactions/config/constants/string_const.dart';
import 'package:business_transactions/models/customer.dart';
import 'package:hive_ce/hive_ce.dart';


/// Manages direct interactions with the Hive database for Customers.
/// Implements Singleton pattern to ensure only one database connection exists.
class CustomerLocalDataSource {
  static final CustomerLocalDataSource instance = CustomerLocalDataSource._();
  static const String boxName = customersBox;

  Box<Customer>? _box;
  bool _initialized = false;

  CustomerLocalDataSource._();

  /// Opens the Hive box. Must be called before any data operations.
  Future<void> init() async {
    if (_initialized) return;
    _box = await Hive.openBox<Customer>(boxName);
    _initialized = true;
  }

  /// Retrieves all customers from local storage.
  Future<List<Customer>> getAllCustomers() async {
    try {
      _ensureInitialized();
      return _box!.values.toList();
    } catch (e) {
      throw Exception('$couldNotFetchCustomersException$colon $e');
    }
  }

  /// Adds a new customer or updates an existing one if the ID matches.
  Future<void> addOrUpdateCustomer(Customer customer) async {
    try {
      _ensureInitialized();
      // Using 'put' with an ID allows for both insertion and updates.
      await _box!.put(customer.id, customer);
    } catch (e) {
      throw Exception(
          '$couldNotSaveCustomerException ${customer.name}$colon $e');
    }
  }

  /// Permanently deletes a customer by ID.
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

  /// Safety check to prevent operations on a closed or uninitialized box.
  void _ensureInitialized() {
    if (!_box!.isOpen || !_initialized || _box == null) {
      throw Exception(dataSourceNotInitializedException);
    }
  }
}
