import 'package:business_transactions/data/local/customer_local_data_source.dart';
import 'package:business_transactions/models/customer.dart';

class CustomerRepository {
  final CustomerLocalDataSource localDataSource;

  CustomerRepository(this.localDataSource);

  Future<List<Customer>> fetchCustomers() {
    return localDataSource.getAllCustomers();
  }

  Future<void> saveCustomer(Customer customer) {
    return localDataSource.addOrUpdateCustomer(customer);
  }

  Future<void> removeCustomer(String customerId) {
    return localDataSource.deleteCustomer(customerId);
  }

  Future<Customer?> fetchCustomerById(String customerId) {
    return localDataSource.getCustomerById(customerId);
  }
}
