import 'package:business_transactions/core/bootstrap/bootstrap.dart';
import 'package:business_transactions/config/my_theme.dart';
import 'package:business_transactions/features/splash/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  // 1. SYSTEM CHECK: Ensures Flutter's native engine is ready before we run any code.
  // We need this because we are accessing the file system (Hive) before the UI loads.
  WidgetsFlutterBinding.ensureInitialized();


  // 2. INITIALIZATION LAYER (The "Bootstrap" Pattern):
  // We moved all startup logic (Database init, Third-party SDKs) into this function.
  // This keeps main() clean and makes it easier to test the app later.
  await bootstrap(); // centralized init logic


  // 3. STATE MANAGEMENT ROOT:
  // ProviderScope is the "Parent" widget for Riverpod. It stores the state of
  // all controllers. Without this, the app cannot access any logic.
  runApp(const ProviderScope(
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static final MaterialTheme myTheme = MaterialTheme(const TextTheme());

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: myTheme.light(),
        darkTheme: myTheme.dark(),
        themeMode: ThemeMode.system,
        home: const SplashScreen());
  }
}
