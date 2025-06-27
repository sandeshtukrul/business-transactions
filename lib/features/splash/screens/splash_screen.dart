import 'package:business_transactions/config/constants/string_const.dart';
import 'package:business_transactions/features/home/screens/home_screen.dart';
import 'package:business_transactions/features/home/widgets/error_view.dart';
import 'package:business_transactions/features/splash/controllers/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue<void>>(splashControllerProvider, (previous, next) {
      // Only navigate if the state is data and it has changed.
      if (next is AsyncData && next != previous) {
        // Schedule navigation for after the current build cycle.
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
        body: splashState.when(
          data: (_) => _buildLottie(),
          error: (error, stackTrace) => ErrorView(
            error: error,
            stackTrace: stackTrace,
            title: splashInitializationFailedTitle,
            onRetry: () => ref.invalidate(splashControllerProvider),
          ),
          loading: () => _buildLottie(),
        ));
  }

  Widget _buildLottie() {
    return Center(
      child: Lottie.asset(
        splashLottiePath,
        width: 300,
        height: 300,
      ),
    );
  }
}
