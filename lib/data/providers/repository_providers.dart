import 'package:business_transactions/data/local/customer_local_data_source.dart';
import 'package:business_transactions/data/repositories/customer_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'repository_providers.g.dart';

/// Provides the singleton instance of the local data source.
/// 'keepAlive: true' ensures the database connection remains open throughout the app session.
@Riverpod(keepAlive: true)
CustomerLocalDataSource customerLocalDataSource(Ref ref) {
  return CustomerLocalDataSource.instance;
}

/// Provides the CustomerRepository.
/// Acts as the central point for UI layers to access data logic.
@Riverpod(keepAlive: true)
CustomerRepository customerRepository(Ref ref) {
  final localDataSource = ref.watch(customerLocalDataSourceProvider);
  return CustomerRepository(localDataSource);
}
