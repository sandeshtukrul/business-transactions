import 'package:business_transactions/core/bootstrap/bootstrap.dart';
import 'package:business_transactions/config/my_theme.dart';
import 'package:business_transactions/features/splash/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// App Entry Point.
void main() async {
  // 1. SYSTEM CHECK: Ensures Flutter's native engine is ready before we run any code.
  // Required for platform channels (Hive, SharedPreferences, etc.) to work 
  // before the UI is rendered.
  WidgetsFlutterBinding.ensureInitialized();


  // 2. INITIALIZATION LAYER (The "Bootstrap" Pattern):
  // Initialize core services (Database, Configs) before the app starts.
  // This prevents "Database not open" errors on the first screen.
  await bootstrap();


  // 3. STATE MANAGEMENT ROOT:
  // ProviderScope is the root of the Riverpod state management system.
  // It stores the state of all providers in the app.
  runApp(const ProviderScope(
    child: MyApp(),
  ));
}

/// The Root Widget of the application.
/// Sets up global configurations like Themes and Routing.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static final MaterialTheme myTheme = MaterialTheme(const TextTheme());

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,

        // Theme Configuration (Supports System Light/Dark mode preference)
        theme: myTheme.light(),
        darkTheme: myTheme.dark(),
        themeMode: ThemeMode.system,

        // Start with the Splash Screen to handle any post-launch initialization checks
        home: const SplashScreen());
  }
}
