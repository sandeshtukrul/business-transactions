import 'package:business_transactions/models/customer.dart';
import 'package:business_transactions/models/transaction.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'customer_details_state.freezed.dart';


/// Holds the UI state for the Customer Details screen.
/// Uses [Freezed] for immutability and copyWith support.
@freezed
class CustomerDetailsState with _$CustomerDetailsState {
  const factory CustomerDetailsState({
    /// The customer object being displayed.
    Customer? customer,

    /// Transient state holding the last deleted transaction for "Undo" functionality.
    /// Format: (Transaction Object, Original Index)
    (Transaction, int)? lastDeletedTransaction,
  }) = _CustomerDetailsState;
}
