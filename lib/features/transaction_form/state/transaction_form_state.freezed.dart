// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transaction_form_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TransactionFormState {
// Determines what fields are shown and what happens on save
  FormMode get mode =>
      throw _privateConstructorUsedError; // Tracks submission state to show loading indicators on the save button
  FormStatus get status =>
      throw _privateConstructorUsedError; // Initial data for Edit mode
  Customer? get initialCustomer => throw _privateConstructorUsedError;
  Transaction? get initialTransaction =>
      throw _privateConstructorUsedError; // Form Fields Values
  TransactionType get transactionType => throw _privateConstructorUsedError;
  String? get selectedPaymentMethod => throw _privateConstructorUsedError;
  DateTime? get selectedDateTime =>
      throw _privateConstructorUsedError; // The created/updated object returned to the previous screen
  Object? get result => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;

  /// Create a copy of TransactionFormState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TransactionFormStateCopyWith<TransactionFormState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransactionFormStateCopyWith<$Res> {
  factory $TransactionFormStateCopyWith(TransactionFormState value,
          $Res Function(TransactionFormState) then) =
      _$TransactionFormStateCopyWithImpl<$Res, TransactionFormState>;
  @useResult
  $Res call(
      {FormMode mode,
      FormStatus status,
      Customer? initialCustomer,
      Transaction? initialTransaction,
      TransactionType transactionType,
      String? selectedPaymentMethod,
      DateTime? selectedDateTime,
      Object? result,
      String? errorMessage});
}

/// @nodoc
class _$TransactionFormStateCopyWithImpl<$Res,
        $Val extends TransactionFormState>
    implements $TransactionFormStateCopyWith<$Res> {
  _$TransactionFormStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TransactionFormState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mode = null,
    Object? status = null,
    Object? initialCustomer = freezed,
    Object? initialTransaction = freezed,
    Object? transactionType = null,
    Object? selectedPaymentMethod = freezed,
    Object? selectedDateTime = freezed,
    Object? result = freezed,
    Object? errorMessage = freezed,
  }) {
    return _then(_value.copyWith(
      mode: null == mode
          ? _value.mode
          : mode // ignore: cast_nullable_to_non_nullable
              as FormMode,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as FormStatus,
      initialCustomer: freezed == initialCustomer
          ? _value.initialCustomer
          : initialCustomer // ignore: cast_nullable_to_non_nullable
              as Customer?,
      initialTransaction: freezed == initialTransaction
          ? _value.initialTransaction
          : initialTransaction // ignore: cast_nullable_to_non_nullable
              as Transaction?,
      transactionType: null == transactionType
          ? _value.transactionType
          : transactionType // ignore: cast_nullable_to_non_nullable
              as TransactionType,
      selectedPaymentMethod: freezed == selectedPaymentMethod
          ? _value.selectedPaymentMethod
          : selectedPaymentMethod // ignore: cast_nullable_to_non_nullable
              as String?,
      selectedDateTime: freezed == selectedDateTime
          ? _value.selectedDateTime
          : selectedDateTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      result: freezed == result ? _value.result : result,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TransactionFormStateImplCopyWith<$Res>
    implements $TransactionFormStateCopyWith<$Res> {
  factory _$$TransactionFormStateImplCopyWith(_$TransactionFormStateImpl value,
          $Res Function(_$TransactionFormStateImpl) then) =
      __$$TransactionFormStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {FormMode mode,
      FormStatus status,
      Customer? initialCustomer,
      Transaction? initialTransaction,
      TransactionType transactionType,
      String? selectedPaymentMethod,
      DateTime? selectedDateTime,
      Object? result,
      String? errorMessage});
}

/// @nodoc
class __$$TransactionFormStateImplCopyWithImpl<$Res>
    extends _$TransactionFormStateCopyWithImpl<$Res, _$TransactionFormStateImpl>
    implements _$$TransactionFormStateImplCopyWith<$Res> {
  __$$TransactionFormStateImplCopyWithImpl(_$TransactionFormStateImpl _value,
      $Res Function(_$TransactionFormStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of TransactionFormState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mode = null,
    Object? status = null,
    Object? initialCustomer = freezed,
    Object? initialTransaction = freezed,
    Object? transactionType = null,
    Object? selectedPaymentMethod = freezed,
    Object? selectedDateTime = freezed,
    Object? result = freezed,
    Object? errorMessage = freezed,
  }) {
    return _then(_$TransactionFormStateImpl(
      mode: null == mode
          ? _value.mode
          : mode // ignore: cast_nullable_to_non_nullable
              as FormMode,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as FormStatus,
      initialCustomer: freezed == initialCustomer
          ? _value.initialCustomer
          : initialCustomer // ignore: cast_nullable_to_non_nullable
              as Customer?,
      initialTransaction: freezed == initialTransaction
          ? _value.initialTransaction
          : initialTransaction // ignore: cast_nullable_to_non_nullable
              as Transaction?,
      transactionType: null == transactionType
          ? _value.transactionType
          : transactionType // ignore: cast_nullable_to_non_nullable
              as TransactionType,
      selectedPaymentMethod: freezed == selectedPaymentMethod
          ? _value.selectedPaymentMethod
          : selectedPaymentMethod // ignore: cast_nullable_to_non_nullable
              as String?,
      selectedDateTime: freezed == selectedDateTime
          ? _value.selectedDateTime
          : selectedDateTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      result: freezed == result ? _value.result : result,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$TransactionFormStateImpl implements _TransactionFormState {
  const _$TransactionFormStateImpl(
      {required this.mode,
      this.status = FormStatus.initial,
      this.initialCustomer,
      this.initialTransaction,
      this.transactionType = TransactionType.sent,
      this.selectedPaymentMethod,
      this.selectedDateTime,
      this.result,
      this.errorMessage});

// Determines what fields are shown and what happens on save
  @override
  final FormMode mode;
// Tracks submission state to show loading indicators on the save button
  @override
  @JsonKey()
  final FormStatus status;
// Initial data for Edit mode
  @override
  final Customer? initialCustomer;
  @override
  final Transaction? initialTransaction;
// Form Fields Values
  @override
  @JsonKey()
  final TransactionType transactionType;
  @override
  final String? selectedPaymentMethod;
  @override
  final DateTime? selectedDateTime;
// The created/updated object returned to the previous screen
  @override
  final Object? result;
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'TransactionFormState(mode: $mode, status: $status, initialCustomer: $initialCustomer, initialTransaction: $initialTransaction, transactionType: $transactionType, selectedPaymentMethod: $selectedPaymentMethod, selectedDateTime: $selectedDateTime, result: $result, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransactionFormStateImpl &&
            (identical(other.mode, mode) || other.mode == mode) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.initialCustomer, initialCustomer) ||
                other.initialCustomer == initialCustomer) &&
            (identical(other.initialTransaction, initialTransaction) ||
                other.initialTransaction == initialTransaction) &&
            (identical(other.transactionType, transactionType) ||
                other.transactionType == transactionType) &&
            (identical(other.selectedPaymentMethod, selectedPaymentMethod) ||
                other.selectedPaymentMethod == selectedPaymentMethod) &&
            (identical(other.selectedDateTime, selectedDateTime) ||
                other.selectedDateTime == selectedDateTime) &&
            const DeepCollectionEquality().equals(other.result, result) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      mode,
      status,
      initialCustomer,
      initialTransaction,
      transactionType,
      selectedPaymentMethod,
      selectedDateTime,
      const DeepCollectionEquality().hash(result),
      errorMessage);

  /// Create a copy of TransactionFormState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TransactionFormStateImplCopyWith<_$TransactionFormStateImpl>
      get copyWith =>
          __$$TransactionFormStateImplCopyWithImpl<_$TransactionFormStateImpl>(
              this, _$identity);
}

abstract class _TransactionFormState implements TransactionFormState {
  const factory _TransactionFormState(
      {required final FormMode mode,
      final FormStatus status,
      final Customer? initialCustomer,
      final Transaction? initialTransaction,
      final TransactionType transactionType,
      final String? selectedPaymentMethod,
      final DateTime? selectedDateTime,
      final Object? result,
      final String? errorMessage}) = _$TransactionFormStateImpl;

// Determines what fields are shown and what happens on save
  @override
  FormMode
      get mode; // Tracks submission state to show loading indicators on the save button
  @override
  FormStatus get status; // Initial data for Edit mode
  @override
  Customer? get initialCustomer;
  @override
  Transaction? get initialTransaction; // Form Fields Values
  @override
  TransactionType get transactionType;
  @override
  String? get selectedPaymentMethod;
  @override
  DateTime?
      get selectedDateTime; // The created/updated object returned to the previous screen
  @override
  Object? get result;
  @override
  String? get errorMessage;

  /// Create a copy of TransactionFormState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TransactionFormStateImplCopyWith<_$TransactionFormStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
