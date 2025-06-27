import 'package:business_transactions/core/bootstrap/bootstrap.dart';
import 'package:business_transactions/config/my_theme.dart';
import 'package:business_transactions/features/splash/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await bootstrap(); // centralized init logic

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
