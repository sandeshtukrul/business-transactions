import 'package:business_transactions/config/constants/string_const.dart';
import 'package:business_transactions/models/customer.dart';
import 'package:hive_ce/hive_ce.dart';


/// Manages direct interactions with the Hive database for Customers.
class CustomerLocalDataSource {

  final Box<Customer> _box;

  CustomerLocalDataSource(this._box);

  /// Retrieves all customers from local storage.
  Future<List<Customer>> getAllCustomers() async {
    try {
      return _box.values.toList();
    } catch (e) {
      throw Exception('$couldNotFetchCustomersException$colon $e');
    }
  }

  /// Adds a new customer or updates an existing one if the ID matches.
  Future<void> addOrUpdateCustomer(Customer customer) async {
    try {
      // Using 'put' with an ID allows for both insertion and updates.
      await _box.put(customer.id, customer);
    } catch (e) {
      throw Exception(
          '$couldNotSaveCustomerException ${customer.name}$colon $e');
    }
  }

  /// Permanently deletes a customer by ID.
  Future<void> deleteCustomer(String customerId) async {
    try {
      await _box.delete(customerId);
    } catch (e) {
      throw Exception('$couldNotDeleteCustomerException($customerId)$colon $e');
    }
  }

  Future<Customer?> getCustomerById(String customerId) async {
    try {
      return _box.get(customerId);
    } catch (e) {
      throw Exception(
          '$couldNotFetchCustomerByIdException ($customerId)$colon $e');
    }
  }
}
