import 'package:business_transactions/models/customer.dart';
import 'package:business_transactions/models/transaction.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'customer_details_state.freezed.dart';

@freezed
class CustomerDetailsState with _$CustomerDetailsState {
  const factory CustomerDetailsState({
    // This holds the actual customer data
    Customer? customer,

    // This holds the temporary UI state for the undo action
    (Transaction, int)? lastDeletedTransaction,
  }) = _CustomerDetailsState;
}
