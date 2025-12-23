import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'splash_controller.g.dart';


/// Manages the application startup logic.
/// Ensures all necessary checks (Auth, Configs) are complete before navigation.
@riverpod
Future<void> splashController(Ref ref) async {

  // Real initialization logic goes here (e.g., checking user session, fetching remote config).
  Future<void> initializeAppLogic() async {
    // Simulating network/database delay.
    await Future.delayed(const Duration(seconds: 1));
  }

  // UX PATTERN (Minimum Duration):
  // wait for initialization, but enforce a minimum splash duration
  // to avoid flicker on fast startups.
  await Future.wait([
    initializeAppLogic(),
    Future.delayed(const Duration(seconds: 2)),
  ]);
}
