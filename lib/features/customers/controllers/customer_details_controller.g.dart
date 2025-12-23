// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_details_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$customerDetailsControllerHash() =>
    r'caa174e0a611efe7381afaafc589dace758d8c4e';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$CustomerDetailsController
    extends BuildlessAutoDisposeAsyncNotifier<CustomerDetailsState> {
  late final String customerId;

  FutureOr<CustomerDetailsState> build(
    String customerId,
  );
}

/// Manages the state for the Customer Details Screen.
/// Handles CRUD operations for transactions and syncs with the Repository.
///
/// Copied from [CustomerDetailsController].
@ProviderFor(CustomerDetailsController)
const customerDetailsControllerProvider = CustomerDetailsControllerFamily();

/// Manages the state for the Customer Details Screen.
/// Handles CRUD operations for transactions and syncs with the Repository.
///
/// Copied from [CustomerDetailsController].
class CustomerDetailsControllerFamily
    extends Family<AsyncValue<CustomerDetailsState>> {
  /// Manages the state for the Customer Details Screen.
  /// Handles CRUD operations for transactions and syncs with the Repository.
  ///
  /// Copied from [CustomerDetailsController].
  const CustomerDetailsControllerFamily();

  /// Manages the state for the Customer Details Screen.
  /// Handles CRUD operations for transactions and syncs with the Repository.
  ///
  /// Copied from [CustomerDetailsController].
  CustomerDetailsControllerProvider call(
    String customerId,
  ) {
    return CustomerDetailsControllerProvider(
      customerId,
    );
  }

  @override
  CustomerDetailsControllerProvider getProviderOverride(
    covariant CustomerDetailsControllerProvider provider,
  ) {
    return call(
      provider.customerId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'customerDetailsControllerProvider';
}

/// Manages the state for the Customer Details Screen.
/// Handles CRUD operations for transactions and syncs with the Repository.
///
/// Copied from [CustomerDetailsController].
class CustomerDetailsControllerProvider
    extends AutoDisposeAsyncNotifierProviderImpl<CustomerDetailsController,
        CustomerDetailsState> {
  /// Manages the state for the Customer Details Screen.
  /// Handles CRUD operations for transactions and syncs with the Repository.
  ///
  /// Copied from [CustomerDetailsController].
  CustomerDetailsControllerProvider(
    String customerId,
  ) : this._internal(
          () => CustomerDetailsController()..customerId = customerId,
          from: customerDetailsControllerProvider,
          name: r'customerDetailsControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$customerDetailsControllerHash,
          dependencies: CustomerDetailsControllerFamily._dependencies,
          allTransitiveDependencies:
              CustomerDetailsControllerFamily._allTransitiveDependencies,
          customerId: customerId,
        );

  CustomerDetailsControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.customerId,
  }) : super.internal();

  final String customerId;

  @override
  FutureOr<CustomerDetailsState> runNotifierBuild(
    covariant CustomerDetailsController notifier,
  ) {
    return notifier.build(
      customerId,
    );
  }

  @override
  Override overrideWith(CustomerDetailsController Function() create) {
    return ProviderOverride(
      origin: this,
      override: CustomerDetailsControllerProvider._internal(
        () => create()..customerId = customerId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        customerId: customerId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<CustomerDetailsController,
      CustomerDetailsState> createElement() {
    return _CustomerDetailsControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CustomerDetailsControllerProvider &&
        other.customerId == customerId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, customerId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin CustomerDetailsControllerRef
    on AutoDisposeAsyncNotifierProviderRef<CustomerDetailsState> {
  /// The parameter `customerId` of this provider.
  String get customerId;
}

class _CustomerDetailsControllerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<CustomerDetailsController,
        CustomerDetailsState> with CustomerDetailsControllerRef {
  _CustomerDetailsControllerProviderElement(super.provider);

  @override
  String get customerId =>
      (origin as CustomerDetailsControllerProvider).customerId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
