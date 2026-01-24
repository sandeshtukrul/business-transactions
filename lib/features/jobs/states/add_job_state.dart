import 'package:business_transactions/models/customer.dart';
import 'package:business_transactions/models/transaction.dart';
import 'package:business_transactions/models/vehicle.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_job_state.freezed.dart';

@freezed
class AddJobState with _$AddJobState {
  const factory AddJobState({
    // Status of the "Save" button
    @Default(false) bool isSubmitting,
    String? errorMessage,

    // Triggers UI to show red borders/text
    @Default(false) bool showFormErrors,
    
    // Form Data
    Customer? selectedCustomer,
    Vehicle? selectedVehicle,
    @Default(0.0) double estimatedAmount,

    @Default("") String jobTitle, 
    required DateTime selectedDate,
    
    // --- ADVANCE PAYMENT MINI-FORM ---
    @Default(false) bool isAdvancePayment,
    @Default(0.0) double advanceAmount,
    
    // Default to UPI
    @Default(PaymentMethod.upi) PaymentMethod paymentMode,
    
    // Helper: List of vehicles belonging to the selected customer
    @Default([]) List<Vehicle> customerVehicles,
  }) = _AddJobState;
  
  const AddJobState._();

  // Helper getter to validate if "Save" button should be enabled
  bool get isValid => selectedCustomer != null && selectedVehicle != null;
}