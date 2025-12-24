import 'package:business_transactions/config/constants/string_const.dart';
import 'package:business_transactions/features/home/screens/home_screen.dart';
import 'package:business_transactions/features/home/widgets/error_view.dart';
import 'package:business_transactions/features/splash/controllers/splash_controller.dart';
import 'package:business_transactions/features/splash/widgets/splash_branding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    // React to splash initialization state changes.
    ref.listen<AsyncValue<void>>(splashControllerProvider, (previous, next) {
      
      // Navigate only when initialization completes successfully
      // and this is a new state (prevents duplicate navigation).
      if (next is AsyncData && next != previous) {
        // Defer navigation until after the current build completes.
        Future.microtask(() {
          if (!context.mounted) return;
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
        });
      }
    });

    final splashState = ref.watch(splashControllerProvider);

    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primary,
        // Robustly handle loading and error states during startup.
        body: splashState.when(
          data: (_) => const SplashBranding(),
          error: (error, stackTrace) => ErrorView(
            error: error,
            stackTrace: stackTrace,
            title: splashInitializationFailedTitle,
            onRetry: () => ref.invalidate(splashControllerProvider),
          ),
          loading: () => const SplashBranding(),
        ),
        );
  }
}
