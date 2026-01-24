// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_job_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$allCustomersHash() => r'fd986e6b10696ff4b2c520f8744c336e8f0069dc';

/// See also [allCustomers].
@ProviderFor(allCustomers)
final allCustomersProvider = AutoDisposeFutureProvider<List<Customer>>.internal(
  allCustomers,
  name: r'allCustomersProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$allCustomersHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AllCustomersRef = AutoDisposeFutureProviderRef<List<Customer>>;
String _$addJobControllerHash() => r'5f5104664963056a344f0d1a3569e8a3552b5f09';

/// See also [AddJobController].
@ProviderFor(AddJobController)
final addJobControllerProvider =
    AutoDisposeNotifierProvider<AddJobController, AddJobState>.internal(
  AddJobController.new,
  name: r'addJobControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$addJobControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AddJobController = AutoDisposeNotifier<AddJobState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
