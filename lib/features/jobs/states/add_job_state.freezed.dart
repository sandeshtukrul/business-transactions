// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'add_job_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AddJobState {
// Status of the "Save" button
  bool get isSubmitting => throw _privateConstructorUsedError;
  String? get errorMessage =>
      throw _privateConstructorUsedError; // Triggers UI to show red borders/text
  bool get showFormErrors => throw _privateConstructorUsedError; // Form Data
  Customer? get selectedCustomer => throw _privateConstructorUsedError;
  Vehicle? get selectedVehicle => throw _privateConstructorUsedError;
  double get estimatedAmount => throw _privateConstructorUsedError;
  String get jobTitle => throw _privateConstructorUsedError;
  DateTime get selectedDate =>
      throw _privateConstructorUsedError; // --- ADVANCE PAYMENT MINI-FORM ---
  bool get isAdvancePayment => throw _privateConstructorUsedError;
  double get advanceAmount =>
      throw _privateConstructorUsedError; // Default to UPI
  PaymentMethod get paymentMode =>
      throw _privateConstructorUsedError; // Helper: List of vehicles belonging to the selected customer
  List<Vehicle> get customerVehicles => throw _privateConstructorUsedError;

  /// Create a copy of AddJobState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AddJobStateCopyWith<AddJobState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddJobStateCopyWith<$Res> {
  factory $AddJobStateCopyWith(
          AddJobState value, $Res Function(AddJobState) then) =
      _$AddJobStateCopyWithImpl<$Res, AddJobState>;
  @useResult
  $Res call(
      {bool isSubmitting,
      String? errorMessage,
      bool showFormErrors,
      Customer? selectedCustomer,
      Vehicle? selectedVehicle,
      double estimatedAmount,
      String jobTitle,
      DateTime selectedDate,
      bool isAdvancePayment,
      double advanceAmount,
      PaymentMethod paymentMode,
      List<Vehicle> customerVehicles});
}

/// @nodoc
class _$AddJobStateCopyWithImpl<$Res, $Val extends AddJobState>
    implements $AddJobStateCopyWith<$Res> {
  _$AddJobStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AddJobState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isSubmitting = null,
    Object? errorMessage = freezed,
    Object? showFormErrors = null,
    Object? selectedCustomer = freezed,
    Object? selectedVehicle = freezed,
    Object? estimatedAmount = null,
    Object? jobTitle = null,
    Object? selectedDate = null,
    Object? isAdvancePayment = null,
    Object? advanceAmount = null,
    Object? paymentMode = null,
    Object? customerVehicles = null,
  }) {
    return _then(_value.copyWith(
      isSubmitting: null == isSubmitting
          ? _value.isSubmitting
          : isSubmitting // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      showFormErrors: null == showFormErrors
          ? _value.showFormErrors
          : showFormErrors // ignore: cast_nullable_to_non_nullable
              as bool,
      selectedCustomer: freezed == selectedCustomer
          ? _value.selectedCustomer
          : selectedCustomer // ignore: cast_nullable_to_non_nullable
              as Customer?,
      selectedVehicle: freezed == selectedVehicle
          ? _value.selectedVehicle
          : selectedVehicle // ignore: cast_nullable_to_non_nullable
              as Vehicle?,
      estimatedAmount: null == estimatedAmount
          ? _value.estimatedAmount
          : estimatedAmount // ignore: cast_nullable_to_non_nullable
              as double,
      jobTitle: null == jobTitle
          ? _value.jobTitle
          : jobTitle // ignore: cast_nullable_to_non_nullable
              as String,
      selectedDate: null == selectedDate
          ? _value.selectedDate
          : selectedDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isAdvancePayment: null == isAdvancePayment
          ? _value.isAdvancePayment
          : isAdvancePayment // ignore: cast_nullable_to_non_nullable
              as bool,
      advanceAmount: null == advanceAmount
          ? _value.advanceAmount
          : advanceAmount // ignore: cast_nullable_to_non_nullable
              as double,
      paymentMode: null == paymentMode
          ? _value.paymentMode
          : paymentMode // ignore: cast_nullable_to_non_nullable
              as PaymentMethod,
      customerVehicles: null == customerVehicles
          ? _value.customerVehicles
          : customerVehicles // ignore: cast_nullable_to_non_nullable
              as List<Vehicle>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AddJobStateImplCopyWith<$Res>
    implements $AddJobStateCopyWith<$Res> {
  factory _$$AddJobStateImplCopyWith(
          _$AddJobStateImpl value, $Res Function(_$AddJobStateImpl) then) =
      __$$AddJobStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isSubmitting,
      String? errorMessage,
      bool showFormErrors,
      Customer? selectedCustomer,
      Vehicle? selectedVehicle,
      double estimatedAmount,
      String jobTitle,
      DateTime selectedDate,
      bool isAdvancePayment,
      double advanceAmount,
      PaymentMethod paymentMode,
      List<Vehicle> customerVehicles});
}

/// @nodoc
class __$$AddJobStateImplCopyWithImpl<$Res>
    extends _$AddJobStateCopyWithImpl<$Res, _$AddJobStateImpl>
    implements _$$AddJobStateImplCopyWith<$Res> {
  __$$AddJobStateImplCopyWithImpl(
      _$AddJobStateImpl _value, $Res Function(_$AddJobStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of AddJobState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isSubmitting = null,
    Object? errorMessage = freezed,
    Object? showFormErrors = null,
    Object? selectedCustomer = freezed,
    Object? selectedVehicle = freezed,
    Object? estimatedAmount = null,
    Object? jobTitle = null,
    Object? selectedDate = null,
    Object? isAdvancePayment = null,
    Object? advanceAmount = null,
    Object? paymentMode = null,
    Object? customerVehicles = null,
  }) {
    return _then(_$AddJobStateImpl(
      isSubmitting: null == isSubmitting
          ? _value.isSubmitting
          : isSubmitting // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      showFormErrors: null == showFormErrors
          ? _value.showFormErrors
          : showFormErrors // ignore: cast_nullable_to_non_nullable
              as bool,
      selectedCustomer: freezed == selectedCustomer
          ? _value.selectedCustomer
          : selectedCustomer // ignore: cast_nullable_to_non_nullable
              as Customer?,
      selectedVehicle: freezed == selectedVehicle
          ? _value.selectedVehicle
          : selectedVehicle // ignore: cast_nullable_to_non_nullable
              as Vehicle?,
      estimatedAmount: null == estimatedAmount
          ? _value.estimatedAmount
          : estimatedAmount // ignore: cast_nullable_to_non_nullable
              as double,
      jobTitle: null == jobTitle
          ? _value.jobTitle
          : jobTitle // ignore: cast_nullable_to_non_nullable
              as String,
      selectedDate: null == selectedDate
          ? _value.selectedDate
          : selectedDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isAdvancePayment: null == isAdvancePayment
          ? _value.isAdvancePayment
          : isAdvancePayment // ignore: cast_nullable_to_non_nullable
              as bool,
      advanceAmount: null == advanceAmount
          ? _value.advanceAmount
          : advanceAmount // ignore: cast_nullable_to_non_nullable
              as double,
      paymentMode: null == paymentMode
          ? _value.paymentMode
          : paymentMode // ignore: cast_nullable_to_non_nullable
              as PaymentMethod,
      customerVehicles: null == customerVehicles
          ? _value._customerVehicles
          : customerVehicles // ignore: cast_nullable_to_non_nullable
              as List<Vehicle>,
    ));
  }
}

/// @nodoc

class _$AddJobStateImpl extends _AddJobState {
  const _$AddJobStateImpl(
      {this.isSubmitting = false,
      this.errorMessage,
      this.showFormErrors = false,
      this.selectedCustomer,
      this.selectedVehicle,
      this.estimatedAmount = 0.0,
      this.jobTitle = "",
      required this.selectedDate,
      this.isAdvancePayment = false,
      this.advanceAmount = 0.0,
      this.paymentMode = PaymentMethod.upi,
      final List<Vehicle> customerVehicles = const []})
      : _customerVehicles = customerVehicles,
        super._();

// Status of the "Save" button
  @override
  @JsonKey()
  final bool isSubmitting;
  @override
  final String? errorMessage;
// Triggers UI to show red borders/text
  @override
  @JsonKey()
  final bool showFormErrors;
// Form Data
  @override
  final Customer? selectedCustomer;
  @override
  final Vehicle? selectedVehicle;
  @override
  @JsonKey()
  final double estimatedAmount;
  @override
  @JsonKey()
  final String jobTitle;
  @override
  final DateTime selectedDate;
// --- ADVANCE PAYMENT MINI-FORM ---
  @override
  @JsonKey()
  final bool isAdvancePayment;
  @override
  @JsonKey()
  final double advanceAmount;
// Default to UPI
  @override
  @JsonKey()
  final PaymentMethod paymentMode;
// Helper: List of vehicles belonging to the selected customer
  final List<Vehicle> _customerVehicles;
// Helper: List of vehicles belonging to the selected customer
  @override
  @JsonKey()
  List<Vehicle> get customerVehicles {
    if (_customerVehicles is EqualUnmodifiableListView)
      return _customerVehicles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_customerVehicles);
  }

  @override
  String toString() {
    return 'AddJobState(isSubmitting: $isSubmitting, errorMessage: $errorMessage, showFormErrors: $showFormErrors, selectedCustomer: $selectedCustomer, selectedVehicle: $selectedVehicle, estimatedAmount: $estimatedAmount, jobTitle: $jobTitle, selectedDate: $selectedDate, isAdvancePayment: $isAdvancePayment, advanceAmount: $advanceAmount, paymentMode: $paymentMode, customerVehicles: $customerVehicles)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddJobStateImpl &&
            (identical(other.isSubmitting, isSubmitting) ||
                other.isSubmitting == isSubmitting) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.showFormErrors, showFormErrors) ||
                other.showFormErrors == showFormErrors) &&
            (identical(other.selectedCustomer, selectedCustomer) ||
                other.selectedCustomer == selectedCustomer) &&
            (identical(other.selectedVehicle, selectedVehicle) ||
                other.selectedVehicle == selectedVehicle) &&
            (identical(other.estimatedAmount, estimatedAmount) ||
                other.estimatedAmount == estimatedAmount) &&
            (identical(other.jobTitle, jobTitle) ||
                other.jobTitle == jobTitle) &&
            (identical(other.selectedDate, selectedDate) ||
                other.selectedDate == selectedDate) &&
            (identical(other.isAdvancePayment, isAdvancePayment) ||
                other.isAdvancePayment == isAdvancePayment) &&
            (identical(other.advanceAmount, advanceAmount) ||
                other.advanceAmount == advanceAmount) &&
            (identical(other.paymentMode, paymentMode) ||
                other.paymentMode == paymentMode) &&
            const DeepCollectionEquality()
                .equals(other._customerVehicles, _customerVehicles));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      isSubmitting,
      errorMessage,
      showFormErrors,
      selectedCustomer,
      selectedVehicle,
      estimatedAmount,
      jobTitle,
      selectedDate,
      isAdvancePayment,
      advanceAmount,
      paymentMode,
      const DeepCollectionEquality().hash(_customerVehicles));

  /// Create a copy of AddJobState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AddJobStateImplCopyWith<_$AddJobStateImpl> get copyWith =>
      __$$AddJobStateImplCopyWithImpl<_$AddJobStateImpl>(this, _$identity);
}

abstract class _AddJobState extends AddJobState {
  const factory _AddJobState(
      {final bool isSubmitting,
      final String? errorMessage,
      final bool showFormErrors,
      final Customer? selectedCustomer,
      final Vehicle? selectedVehicle,
      final double estimatedAmount,
      final String jobTitle,
      required final DateTime selectedDate,
      final bool isAdvancePayment,
      final double advanceAmount,
      final PaymentMethod paymentMode,
      final List<Vehicle> customerVehicles}) = _$AddJobStateImpl;
  const _AddJobState._() : super._();

// Status of the "Save" button
  @override
  bool get isSubmitting;
  @override
  String? get errorMessage; // Triggers UI to show red borders/text
  @override
  bool get showFormErrors; // Form Data
  @override
  Customer? get selectedCustomer;
  @override
  Vehicle? get selectedVehicle;
  @override
  double get estimatedAmount;
  @override
  String get jobTitle;
  @override
  DateTime get selectedDate; // --- ADVANCE PAYMENT MINI-FORM ---
  @override
  bool get isAdvancePayment;
  @override
  double get advanceAmount; // Default to UPI
  @override
  PaymentMethod
      get paymentMode; // Helper: List of vehicles belonging to the selected customer
  @override
  List<Vehicle> get customerVehicles;

  /// Create a copy of AddJobState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AddJobStateImplCopyWith<_$AddJobStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
