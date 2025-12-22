import 'package:business_transactions/data/local/customer_local_data_source.dart';
import 'package:business_transactions/models/customer.dart';
import 'package:business_transactions/models/transaction.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';


/// BOOTSTRAP:
/// This function is the "Pre-Flight Check" for the app.
/// It initializes essential services (like the Database) before the UI appears.
Future<void> bootstrap() async {
  // 1. Initialize the local database (Hive)
  await Hive.initFlutter();

  
  // 2. REGISTER ADAPTERS:
  // Hive stores data in binary. It doesn't know what a "Customer" is.
  // These adapters teach Hive how to read/write our custom objects.
  Hive.registerAdapter(CustomerAdapter());
  Hive.registerAdapter(TransactionAdapter());
  Hive.registerAdapter(TransactionTypeAdapter());


  // 3. OPEN BOXES:
  // Pre-load the database box so it's instantly available when the user needs it.
  await CustomerLocalDataSource.instance.init();
}
