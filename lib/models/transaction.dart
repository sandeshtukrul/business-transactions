import 'package:hive_ce/hive_ce.dart';
import 'package:uuid/uuid.dart';

part 'transaction.g.dart';


/// Represents a single financial transaction.
@HiveType(typeId: 1)
class Transaction extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String partyName;

  @HiveField(2)
  final String? description;

  /// The transaction amount stored in 'Paisa' (lowest currency unit).
  /// Stored as [int] to avoid floating-point rounding errors (e.g. 1.1 + 2.2 != 3.3).
  @HiveField(3)
  final int amount;

  @HiveField(4)
  final DateTime createdAt;

  @HiveField(5)
  final String paymentMethod;

  @HiveField(6)
  final TransactionType type;

  Transaction({
    String? id,
    required this.partyName,
    this.description,
    required this.amount,
    DateTime? createdAt,
    required this.paymentMethod,
    required this.type,
  })  : id = id ?? const Uuid().v4(),
        createdAt = createdAt ?? DateTime.now();

  /// Creates a copy of the transaction with updated fields.
  Transaction copyWith({
    String? id,
    String? partyName,
    String? description,
    int? amount,
    DateTime? createdAt,
    String? paymentMethod,
    TransactionType? type,
  }) {
    return Transaction(
      id: id ?? this.id,
      partyName: partyName ?? this.partyName,
      description: description ?? this.description,
      amount: amount ?? this.amount,
      createdAt: createdAt ?? this.createdAt,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      type: type ?? this.type,
    );
  }
}

/// Defines the direction of the transaction.
/// Stored as an Enum in Hive to prevent string-based typos ("sent" vs "send").
@HiveType(typeId: 2)
enum TransactionType {
  @HiveField(0)
  sent,        // Money given (Expense/Debit)
  @HiveField(1)
  received,    // Money received (Income/Credit)
}
