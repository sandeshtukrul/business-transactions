import 'package:business_transactions/models/customer.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_state.freezed.dart';

/// Immutable state for the Home Screen.
/// Includes the customer list, aggregate total balance, and undo history.
@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    @Default([]) List<Customer> customers,
    @Default(0) int totalBalance,

    // Stores the last deleted customer and their index for the Undo operation.
    (Customer, int)? lastDeleted,
  }) = _HomeState;
}
