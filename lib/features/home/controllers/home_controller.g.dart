// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$usernameHash() => r'1c94b692d495ae10b58efbe7cbe76e27aca53992';

/// See also [username].
@ProviderFor(username)
final usernameProvider = AutoDisposeProvider<String?>.internal(
  username,
  name: r'usernameProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$usernameHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef UsernameRef = AutoDisposeProviderRef<String?>;
String _$homeScreenControllerHash() =>
    r'032fc7891d548b2517b57a9ebeef7f0c3bdd1135';

/// Manages the state for the Home Screen (Dashboard).
/// Handles fetching customers, calculating total balance, and CRUD operations.
///
/// Copied from [HomeScreenController].
@ProviderFor(HomeScreenController)
final homeScreenControllerProvider =
    AutoDisposeAsyncNotifierProvider<HomeScreenController, HomeState>.internal(
  HomeScreenController.new,
  name: r'homeScreenControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$homeScreenControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$HomeScreenController = AutoDisposeAsyncNotifier<HomeState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
