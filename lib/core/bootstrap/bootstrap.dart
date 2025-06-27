import 'package:business_transactions/data/local/customer_local_data_source.dart';
import 'package:business_transactions/models/customer.dart';
import 'package:business_transactions/models/transaction.dart';
import 'package:hive_flutter/adapters.dart';

Future<void> bootstrap() async {
  await Hive.initFlutter();

  Hive.registerAdapter(CustomerAdapter());
  Hive.registerAdapter(TransactionAdapter());
  Hive.registerAdapter(TransactionTypeAdapter());

  await CustomerLocalDataSource.instance.init();
}
