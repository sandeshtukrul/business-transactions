import 'package:business_transactions/data/providers/repository_providers.dart';
import 'package:business_transactions/features/home/controllers/home_controller.dart';
import 'package:business_transactions/features/jobs/states/add_job_state.dart';
import 'package:business_transactions/models/customer.dart';
import 'package:business_transactions/models/job.dart';
import 'package:business_transactions/models/transaction.dart';
import 'package:business_transactions/models/vehicle.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'add_job_controller.g.dart';

@riverpod
class AddJobController extends _$AddJobController {
  @override
  AddJobState build() {
    return AddJobState(selectedDate: DateTime.now());
  }

  void selectCustomer(Customer customer) {
    state = state.copyWith(
      selectedCustomer: customer,
      customerVehicles: customer.vehicles,
      selectedVehicle: null,
    );
  }

  void selectVehicle(Vehicle? vehicle) {
    state = state.copyWith(selectedVehicle: vehicle);
  }

  void setEstimatedAmount(double? value) {
    state = state.copyWith(estimatedAmount: value ?? 0.0);
  }

  void setJobTitle(String value) {
    state = state.copyWith(jobTitle: value);
  }

  void selectDate(DateTime date) {
    state = state.copyWith(selectedDate: date);
  }

  void toggleAdvancePayment(bool value) {
    state = state.copyWith(isAdvancePayment: value);
  }

  void setAdvanceAmount(double amount) {
    state = state.copyWith(advanceAmount: amount);
  }

  void setPaymentMode(PaymentMethod mode) {
    state = state.copyWith(paymentMode: mode);
  }

  Future<String?> submitJob() async {
    final s = state;

    // 1. Check validity
    bool isValid = true;
    if (s.selectedCustomer == null) isValid = false;
    if (s.selectedVehicle == null) isValid = false;
    if (s.jobTitle.trim().isEmpty) isValid = false;
    // Note: We allow estimatedAmount to be 0 if you want optional quotes,
    // but if you want it mandatory, add: if (s.estimatedAmount <= 0) isValid = false;

    // 2. If invalid, SHOW ERRORS and STOP
    if (!isValid) {
      state = state.copyWith(showFormErrors: true);
      return null; // Return null so button stops loading, but UI shows red
    }

    // 3. If valid, proceed (and hide errors)
    state = state.copyWith(isSubmitting: true, showFormErrors: false);

    try {
      final jobRepo = ref.read(jobRepositoryProvider);

      // 1. SMART TRANSACTION CREATION
      List<Transaction> initialTransactions = [];

      if (s.isAdvancePayment && s.advanceAmount > 0) {
        final int amountInPaisa = (s.advanceAmount * 100).toInt();

        String methodString;
        switch (s.paymentMode) {
          case PaymentMethod.upi:
            methodString = "UPI";
            break;
          case PaymentMethod.cash:
            methodString = "Cash";
            break;
          case PaymentMethod.bank:
            methodString = "Bank";
            break;
          case PaymentMethod.other:
            methodString = "Other";
            break;
        }

        final advanceTransaction = Transaction(
          id: const Uuid().v4(),

          // A. From Mini-Form
          amount: amountInPaisa,
          paymentMethod: methodString,

          // B. Auto-Filled (Smart Defaults)
          type: TransactionType.received, // Advance is ALWAYS received
          createdAt: s.selectedDate, // Matches Job Date
          description: "Advance Payment for ${s.jobTitle}", // Standardized Note
          partyName: s.selectedCustomer!
              .name, // Will be linked when job is saved if using Hive lists
        );
        initialTransactions.add(advanceTransaction);
      }

      final newJob = Job(
        id: const Uuid().v4(),
        customerId: s.selectedCustomer!.id,
        vehicleId: s.selectedVehicle!.id,
        customerNameSnapshot: s.selectedCustomer!.name,
        vehicleNameSnapshot: s.selectedVehicle!.name,
        title: s.jobTitle.trim(),
        totalBill: s.estimatedAmount,
        status: JobStatus.open,
        createdAt: s.selectedDate,
        isAdvancePayment: s.isAdvancePayment,
        transactions: initialTransactions,
      );

      await jobRepo.saveJob(newJob);

      ref.invalidate(homeScreenControllerProvider);


      state = state.copyWith(isSubmitting: false);
      return "SUCCESS"; // Special string to tell UI to close
    } catch (e) {
      state = state.copyWith(isSubmitting: false);
      return "Database Error: $e"; // Real error to show in SnackBar
    }
  }
}

@riverpod
Future<List<Customer>> allCustomers(Ref ref) {
  final repo = ref.watch(customerRepositoryProvider);
  return repo.fetchCustomers();
}
