import 'package:business_transactions/models/transaction.dart';
import 'package:business_transactions/models/vehicle.dart';
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

  // delete this after migration we don't need this 
  // but keep in mind home controller is connected to it as of now
  @HiveField(3)
  final List<Transaction> legacyTransactions;

  @HiveField(4)
  final List<Vehicle> vehicles;

  Customer({
    String? id,
    DateTime? createdAt,
    required this.name,
    List<Transaction>?
        legacyTransactions, // Can be nullable in constructor for convenience
    List<Vehicle>? vehicles,
  })  : id = id ??
            const Uuid().v4(), // Auto-generate a unique ID if none is provided
        createdAt = createdAt ?? DateTime.now(),
        legacyTransactions = legacyTransactions ?? const [],
        vehicles = vehicles ?? const [];

  /// Creates a copy of the customer with updated fields.
  /// Essential for immutable state updates in Riverpod.
  Customer copyWith({
    String? id,
    String? name,
    DateTime? createdAt,
    List<Transaction>? legacyTransactions,
    List<Vehicle>? vehicles,
  }) {
    return Customer(
      id: id ?? this.id,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      legacyTransactions: legacyTransactions ?? this.legacyTransactions,
      vehicles: vehicles ?? this.vehicles,
    );
  }

  /// Helper to check if this customer needs migration
  bool get hasLegacyData => legacyTransactions.isNotEmpty;
}
