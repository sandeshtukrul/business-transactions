import 'package:business_transactions/models/transaction.dart';
import 'package:hive_ce/hive_ce.dart';
import 'package:uuid/uuid.dart';

part 'customer.g.dart';

// DATA MODEL:
// This class defines what a "Customer" looks like.
// It extends HiveObject, which gives it abilities like .save() and .delete()
@HiveType(typeId: 0)
class Customer extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final DateTime createdAt;

  @HiveField(3)
  final List<Transaction> transactions;

  Customer({
    String? id,
    DateTime? createdAt,
    required this.name,
    List<Transaction>?
        transactions, // Can be nullable in constructor for convenience
  })  : id = id ?? const Uuid().v4(), // Auto-generate a unique ID if none is provided
        createdAt = createdAt ?? DateTime.now(),
        transactions = transactions ?? const [];


  // IMMUTABILITY PATTERN (copyWith):
  // In Flutter, we avoid changing variables directly.
  // Instead, we create a new copy of the object with the updated values.
  // This prevents accidental bugs where data changes in one place but not another.
  Customer copyWith({
    String? id,
    String? name,
    DateTime? createdAt,
    List<Transaction>? transactions,
  }) {
    return Customer(
      id: id ?? this.id,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      transactions: transactions ?? this.transactions,
    );
  }


  // COMPUTED PROPERTY:
  // We don't store the "Balance" in the database. Why?
  // Because if we edit a transaction, the stored balance would be wrong (out of sync).
  // Instead, we calculate it live every time we need it. 
  // This ensures the balance is ALWAYS 100% accurate.
  int get currentBalance {
    return transactions.fold<int>(0, (sum, transaction) {
      if (transaction.type == TransactionType.sent) {
        return sum - transaction.amount;
      } else {
        return sum + transaction.amount;
      }
    });
  }
}
