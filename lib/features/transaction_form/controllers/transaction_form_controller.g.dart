// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_form_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$transactionFormControllerHash() =>
    r'85efd6870ace1dc2d57ec8267ea350e6e369363e';

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

abstract class _$TransactionFormController
    extends BuildlessAutoDisposeNotifier<TransactionFormState> {
  late final Customer? customer;
  late final Transaction? transaction;

  TransactionFormState build({
    Customer? customer,
    Transaction? transaction,
  });
}

/// See also [TransactionFormController].
@ProviderFor(TransactionFormController)
const transactionFormControllerProvider = TransactionFormControllerFamily();

/// See also [TransactionFormController].
class TransactionFormControllerFamily extends Family<TransactionFormState> {
  /// See also [TransactionFormController].
  const TransactionFormControllerFamily();

  /// See also [TransactionFormController].
  TransactionFormControllerProvider call({
    Customer? customer,
    Transaction? transaction,
  }) {
    return TransactionFormControllerProvider(
      customer: customer,
      transaction: transaction,
    );
  }

  @override
  TransactionFormControllerProvider getProviderOverride(
    covariant TransactionFormControllerProvider provider,
  ) {
    return call(
      customer: provider.customer,
      transaction: provider.transaction,
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
  String? get name => r'transactionFormControllerProvider';
}

/// See also [TransactionFormController].
class TransactionFormControllerProvider extends AutoDisposeNotifierProviderImpl<
    TransactionFormController, TransactionFormState> {
  /// See also [TransactionFormController].
  TransactionFormControllerProvider({
    Customer? customer,
    Transaction? transaction,
  }) : this._internal(
          () => TransactionFormController()
            ..customer = customer
            ..transaction = transaction,
          from: transactionFormControllerProvider,
          name: r'transactionFormControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$transactionFormControllerHash,
          dependencies: TransactionFormControllerFamily._dependencies,
          allTransitiveDependencies:
              TransactionFormControllerFamily._allTransitiveDependencies,
          customer: customer,
          transaction: transaction,
        );

  TransactionFormControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.customer,
    required this.transaction,
  }) : super.internal();

  final Customer? customer;
  final Transaction? transaction;

  @override
  TransactionFormState runNotifierBuild(
    covariant TransactionFormController notifier,
  ) {
    return notifier.build(
      customer: customer,
      transaction: transaction,
    );
  }

  @override
  Override overrideWith(TransactionFormController Function() create) {
    return ProviderOverride(
      origin: this,
      override: TransactionFormControllerProvider._internal(
        () => create()
          ..customer = customer
          ..transaction = transaction,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        customer: customer,
        transaction: transaction,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<TransactionFormController,
      TransactionFormState> createElement() {
    return _TransactionFormControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TransactionFormControllerProvider &&
        other.customer == customer &&
        other.transaction == transaction;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, customer.hashCode);
    hash = _SystemHash.combine(hash, transaction.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin TransactionFormControllerRef
    on AutoDisposeNotifierProviderRef<TransactionFormState> {
  /// The parameter `customer` of this provider.
  Customer? get customer;

  /// The parameter `transaction` of this provider.
  Transaction? get transaction;
}

class _TransactionFormControllerProviderElement
    extends AutoDisposeNotifierProviderElement<TransactionFormController,
        TransactionFormState> with TransactionFormControllerRef {
  _TransactionFormControllerProviderElement(super.provider);

  @override
  Customer? get customer =>
      (origin as TransactionFormControllerProvider).customer;
  @override
  Transaction? get transaction =>
      (origin as TransactionFormControllerProvider).transaction;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
