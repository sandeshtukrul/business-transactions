import 'package:business_transactions/models/transaction.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'customer.g.dart';

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
  })  : id = id ?? const Uuid().v4(),
        createdAt = createdAt ?? DateTime.now(),
        transactions = transactions ?? const [];

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
