import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'splash_controller.g.dart';

@riverpod
Future<void> splashController(Ref ref) async {
  Future<void> initializeAppLogic() async {
    // Simulate real work like checking auth, loading settings, etc.
    await Future.delayed(const Duration(seconds: 1));
  }

  await Future.wait([
    initializeAppLogic(),
    Future.delayed(const Duration(seconds: 2)), // Minimum splash time
  ]);
}
