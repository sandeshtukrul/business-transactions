import 'package:business_transactions/data/local/customer_local_data_source.dart';
import 'package:business_transactions/models/customer.dart';
import 'package:business_transactions/models/transaction.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';


/// Initializes essential application services before the UI starts.
/// This acts as the "Pre-flight check" ensuring Database and Configs are ready.
Future<void> bootstrap() async {
  // 1. Initialize the local database (Hive)
  await Hive.initFlutter();

  
  // 2. REGISTER ADAPTERS:
  // Teaches Hive how to serialize/deserialize our custom objects (Customer, Transaction).
  Hive.registerAdapter(CustomerAdapter());
  Hive.registerAdapter(TransactionAdapter());
  Hive.registerAdapter(TransactionTypeAdapter());


  // 3. OPEN BOXES:
  // Pre-open the main database box to prevent loading delays on the Home Screen.
  await CustomerLocalDataSource.instance.init();
}
