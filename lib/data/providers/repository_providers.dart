import 'package:business_transactions/config/constants/string_const.dart';
import 'package:business_transactions/data/local/customer_local_data_source.dart';
import 'package:business_transactions/data/repositories/customer_repository.dart';
import 'package:business_transactions/models/customer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_ce/hive.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'repository_providers.g.dart';

// Provider for CustomerLocalDataSource
@Riverpod(keepAlive: true)
CustomerLocalDataSource customerLocalDataSource(Ref ref) {
  // Retrieve the already-opened box using Hive.box
  final box = Hive.box<Customer>(customersBox);

  return CustomerLocalDataSource(box);
}

/// Provides the CustomerRepository.
/// Acts as the central point for UI layers to access data logic.
@Riverpod(keepAlive: true)
CustomerRepository customerRepository(Ref ref) {
  final localDataSource = ref.watch(customerLocalDataSourceProvider);
  return CustomerRepository(localDataSource);
}
