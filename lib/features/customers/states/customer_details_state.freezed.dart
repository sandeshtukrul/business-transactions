// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'customer_details_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CustomerDetailsState {
  /// The customer object being displayed.
  Customer? get customer => throw _privateConstructorUsedError;

  /// Transient state holding the last deleted transaction for "Undo" functionality.
  /// Format: (Transaction Object, Original Index)
  (Transaction, int)? get lastDeletedTransaction =>
      throw _privateConstructorUsedError;

  /// Create a copy of CustomerDetailsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CustomerDetailsStateCopyWith<CustomerDetailsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CustomerDetailsStateCopyWith<$Res> {
  factory $CustomerDetailsStateCopyWith(CustomerDetailsState value,
          $Res Function(CustomerDetailsState) then) =
      _$CustomerDetailsStateCopyWithImpl<$Res, CustomerDetailsState>;
  @useResult
  $Res call({Customer? customer, (Transaction, int)? lastDeletedTransaction});
}

/// @nodoc
class _$CustomerDetailsStateCopyWithImpl<$Res,
        $Val extends CustomerDetailsState>
    implements $CustomerDetailsStateCopyWith<$Res> {
  _$CustomerDetailsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CustomerDetailsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? customer = freezed,
    Object? lastDeletedTransaction = freezed,
  }) {
    return _then(_value.copyWith(
      customer: freezed == customer
          ? _value.customer
          : customer // ignore: cast_nullable_to_non_nullable
              as Customer?,
      lastDeletedTransaction: freezed == lastDeletedTransaction
          ? _value.lastDeletedTransaction
          : lastDeletedTransaction // ignore: cast_nullable_to_non_nullable
              as (Transaction, int)?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CustomerDetailsStateImplCopyWith<$Res>
    implements $CustomerDetailsStateCopyWith<$Res> {
  factory _$$CustomerDetailsStateImplCopyWith(_$CustomerDetailsStateImpl value,
          $Res Function(_$CustomerDetailsStateImpl) then) =
      __$$CustomerDetailsStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Customer? customer, (Transaction, int)? lastDeletedTransaction});
}

/// @nodoc
class __$$CustomerDetailsStateImplCopyWithImpl<$Res>
    extends _$CustomerDetailsStateCopyWithImpl<$Res, _$CustomerDetailsStateImpl>
    implements _$$CustomerDetailsStateImplCopyWith<$Res> {
  __$$CustomerDetailsStateImplCopyWithImpl(_$CustomerDetailsStateImpl _value,
      $Res Function(_$CustomerDetailsStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of CustomerDetailsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? customer = freezed,
    Object? lastDeletedTransaction = freezed,
  }) {
    return _then(_$CustomerDetailsStateImpl(
      customer: freezed == customer
          ? _value.customer
          : customer // ignore: cast_nullable_to_non_nullable
              as Customer?,
      lastDeletedTransaction: freezed == lastDeletedTransaction
          ? _value.lastDeletedTransaction
          : lastDeletedTransaction // ignore: cast_nullable_to_non_nullable
              as (Transaction, int)?,
    ));
  }
}

/// @nodoc

class _$CustomerDetailsStateImpl implements _CustomerDetailsState {
  const _$CustomerDetailsStateImpl(
      {this.customer, this.lastDeletedTransaction});

  /// The customer object being displayed.
  @override
  final Customer? customer;

  /// Transient state holding the last deleted transaction for "Undo" functionality.
  /// Format: (Transaction Object, Original Index)
  @override
  final (Transaction, int)? lastDeletedTransaction;

  @override
  String toString() {
    return 'CustomerDetailsState(customer: $customer, lastDeletedTransaction: $lastDeletedTransaction)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CustomerDetailsStateImpl &&
            (identical(other.customer, customer) ||
                other.customer == customer) &&
            (identical(other.lastDeletedTransaction, lastDeletedTransaction) ||
                other.lastDeletedTransaction == lastDeletedTransaction));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, customer, lastDeletedTransaction);

  /// Create a copy of CustomerDetailsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CustomerDetailsStateImplCopyWith<_$CustomerDetailsStateImpl>
      get copyWith =>
          __$$CustomerDetailsStateImplCopyWithImpl<_$CustomerDetailsStateImpl>(
              this, _$identity);
}

abstract class _CustomerDetailsState implements CustomerDetailsState {
  const factory _CustomerDetailsState(
          {final Customer? customer,
          final (Transaction, int)? lastDeletedTransaction}) =
      _$CustomerDetailsStateImpl;

  /// The customer object being displayed.
  @override
  Customer? get customer;

  /// Transient state holding the last deleted transaction for "Undo" functionality.
  /// Format: (Transaction Object, Original Index)
  @override
  (Transaction, int)? get lastDeletedTransaction;

  /// Create a copy of CustomerDetailsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CustomerDetailsStateImplCopyWith<_$CustomerDetailsStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
