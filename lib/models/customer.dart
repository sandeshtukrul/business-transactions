import 'package:business_transactions/models/transaction.dart';
import 'package:hive_ce/hive_ce.dart';
import 'package:uuid/uuid.dart';

part 'customer.g.dart';

/// Represents a customer entity in the local database.
/// Extends [HiveObject] to enable direct save/delete operations on instances.
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


  /// Creates a copy of the customer with updated fields.
  /// Essential for immutable state updates in Riverpod.
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


  /// Calculates the current balance dynamically from the transaction history.
  /// This serves as the "Single Source of Truth," preventing synchronization errors
  /// that occur when storing a separate 'balance' field.
  /// This ensures the balance is ALWAYS 100% accurate.
  int get currentBalance {
    return transactions.fold<int>(0, (sum, transaction) {
      if (transaction.type == TransactionType.sent) {
        return sum - transaction.amount; // Outflow (Debit)
      } else {
        return sum + transaction.amount; // Inflow (Credit)
      }
    });
  }
}
