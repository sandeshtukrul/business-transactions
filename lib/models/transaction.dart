import 'package:hive_ce/hive_ce.dart';
import 'package:uuid/uuid.dart';

part 'transaction.g.dart';

@HiveType(typeId: 1)
class Transaction extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String partyName;

  @HiveField(2)
  final String? description;

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

@HiveType(typeId: 2)
enum TransactionType {
  @HiveField(0)
  sent,
  @HiveField(1)
  received,
}
