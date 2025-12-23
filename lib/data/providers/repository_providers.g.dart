// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repository_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$customerLocalDataSourceHash() =>
    r'0cf4663d73d0fe8e9804348867966cde5700dec5';

/// Provides the singleton instance of the local data source.
/// 'keepAlive: true' ensures the database connection remains open throughout the app session.
///
/// Copied from [customerLocalDataSource].
@ProviderFor(customerLocalDataSource)
final customerLocalDataSourceProvider =
    Provider<CustomerLocalDataSource>.internal(
  customerLocalDataSource,
  name: r'customerLocalDataSourceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$customerLocalDataSourceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CustomerLocalDataSourceRef = ProviderRef<CustomerLocalDataSource>;
String _$customerRepositoryHash() =>
    r'20abbd3172155e4a340b9c62648d0fac864b332d';

/// Provides the CustomerRepository.
/// Acts as the central point for UI layers to access data logic.
///
/// Copied from [customerRepository].
@ProviderFor(customerRepository)
final customerRepositoryProvider = Provider<CustomerRepository>.internal(
  customerRepository,
  name: r'customerRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$customerRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CustomerRepositoryRef = ProviderRef<CustomerRepository>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
