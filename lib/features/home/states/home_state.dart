import 'package:business_transactions/models/customer.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_state.freezed.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    @Default([]) List<Customer> customers,
    @Default(0) int totalBalance,
    (Customer, int)? lastDeleted,
  }) = _HomeState;
}
