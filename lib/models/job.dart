import 'package:business_transactions/models/transaction.dart';
import 'package:hive_ce/hive_ce.dart';
import 'package:uuid/uuid.dart';

part 'job.g.dart';

@HiveType(typeId: 6)
enum JobStatus {
  @HiveField(0)
  open,
  @HiveField(1)
  closed,
  @HiveField(2)
  pending, // Added this because Controller uses it
}

@HiveType(typeId: 5)
class Job extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String customerId;

  @HiveField(2)
  final String? vehicleId;

  @HiveField(3)
  final JobStatus status;

  @HiveField(4)
  final DateTime createdAt;

  @HiveField(5)
  final DateTime? closedAt;

  @HiveField(6)
  final List<Transaction> transactions;

  @HiveField(7)
  final String customerNameSnapshot; 

  @HiveField(8)
  final String? vehicleNameSnapshot;

  @HiveField(9)
  final double totalBill; // CHANGED TO DOUBLE (Safer for money)

  // --- NEW FIELD ---
  @HiveField(10)
  final String title; 

  // --- NEW FIELD for Advance Payment Toggle ---
  @HiveField(11)
  final bool isAdvancePayment;

  Job({
    String? id,
    required this.customerId,
    this.vehicleId,
    required this.customerNameSnapshot,
    this.vehicleNameSnapshot,
    this.status = JobStatus.open,
    DateTime? createdAt,
    this.closedAt,
    this.totalBill = 0.0, // Default to 0.0
    List<Transaction>? transactions,
    required this.title, // Required now
    this.isAdvancePayment = false,
  })  : id = id ?? const Uuid().v4(),
        createdAt = createdAt ?? DateTime.now(),
        transactions = transactions ?? [];

  Job copyWith({
    String? id,
    String? customerId,
    String? vehicleId,
    String? customerNameSnapshot,
    String? vehicleNameSnapshot,
    JobStatus? status,
    DateTime? createdAt,
    DateTime? closedAt,
    double? totalBill,
    List<Transaction>? transactions,
    String? title,
    bool? isAdvancePayment,
  }) {
    return Job(
      id: id ?? this.id,
      customerId: customerId ?? this.customerId,
      vehicleId: vehicleId ?? this.vehicleId,
      customerNameSnapshot: customerNameSnapshot ?? this.customerNameSnapshot,
      vehicleNameSnapshot: vehicleNameSnapshot ?? this.vehicleNameSnapshot,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      closedAt: closedAt ?? this.closedAt,
      totalBill: totalBill ?? this.totalBill,
      transactions: transactions ?? this.transactions,
      title: title ?? this.title,
      isAdvancePayment: isAdvancePayment ?? this.isAdvancePayment,
    );
  }

  // --- GETTERS (Updated for Double) ---
  double get totalCollected {
    return transactions
        .where((t) => t.type == TransactionType.received)
        .fold(0.0, (sum, t) => sum + t.amount); // Assuming Transaction amount is double too?
  }

  double get totalExpenses {
    return transactions
        .where((t) => t.type == TransactionType.sent)
        .fold(0.0, (sum, t) => sum + t.amount);
  }

  double get dueAmount => totalBill - totalCollected;

  bool get isFullyPaid => totalBill > 0 && dueAmount <= 0.01; // Float tolerance

  double get cashBalance => totalCollected - totalExpenses;
}