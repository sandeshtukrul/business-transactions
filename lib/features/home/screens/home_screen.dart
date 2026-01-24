import 'package:business_transactions/config/constants/string_const.dart';
import 'package:business_transactions/features/home/controllers/home_controller.dart';
import 'package:business_transactions/features/home/widgets/bottom_nav.dart';
import 'package:business_transactions/features/home/widgets/dashboard_view.dart';
import 'package:business_transactions/features/home/widgets/error_view.dart';
import 'package:business_transactions/features/home/widgets/home_fab.dart';
import 'package:business_transactions/features/home/widgets/mesh_background.dart';
import 'package:business_transactions/features/jobs/screens/add_job_screen.dart';
import 'package:business_transactions/models/customer.dart';
import 'package:business_transactions/shared/helpers/snackbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    // WATCHER: Rebuilds UI when main data changes
    final homeAsyncState = ref.watch(homeScreenControllerProvider);
    final currentUsername = ref.watch(usernameProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // LISTENERS(Undo Logic)
    _setupUndoListener();

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness:
            isDark ? Brightness.light : Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        floatingActionButton: HomeFab(onPressed: _handleFabPressed),
        bottomNavigationBar: BottomNav(
            currentIndex: _currentIndex,
            onTap: (index) => setState(
                  () => _currentIndex = index,
                )),
        body: Stack(
          children: [
            const MeshBackground(),
            SafeArea(
              bottom: false,
              // .when() forces us to handle all 3 states: Data, Error, and Loading.
              child: homeAsyncState.when(
                  data: (homeState) {
                    return _buildBodyContent(currentUsername ?? "User");
                  },
                  error: (err, stack) => ErrorView(
                        error: err,
                        stackTrace: stack,
                        onRetry: () =>
                            ref.invalidate(homeScreenControllerProvider),
                      ),
                  loading: () {
                    // "Ghost Loading" Pattern: Show previous data (faded) + spinner
                    // This prevents the screen from flashing white during refreshes.
                    final previousStateData = ref.watch(
                        homeScreenControllerProvider
                            .select((asyncValue) => asyncValue.valueOrNull));

                    if (previousStateData != null) {
                      return Stack(
                        children: [
                          Opacity(
                            opacity: 0.5,
                            // Right now, _buildDashboardContent uses kMockJobs (the static file).
                            //Later, when we connect the database,
                            //you will pass the homeState into that function like this:
                            // _buildDashboardContent(username, previousStateData.jobs)
                            child: _buildBodyContent(currentUsername ?? 'User'),
                          ),
                          const Center(child: CircularProgressIndicator()),
                        ],
                      );
                    }
                    return const Center(child: CircularProgressIndicator());
                  }),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildBodyContent(String username) {
    switch (_currentIndex) {
      case 0:
        return DashboardView(username: username);
      case 1:
        return const Center(child: Text("Ledger View"));
      case 2:
        return const Center(child: Text("Reports View"));
      default:
        return const SizedBox();
    }
  }

  void _setupUndoListener() {
    // LISTENER: Watches for 'lastDeleted' changes to trigger the Undo Snackbar.
    ref.listen<(Customer, int)?>(
        homeScreenControllerProvider
            .select((asyncState) => asyncState.valueOrNull?.lastDeleted),
        (previous, next) {
      if (next != null) {
        final (deleteCustomer, index) = next;

        SnackbarHelper.showSuccess(
          context,
          '${deleteCustomer.name} $deletedSuccessfully',
          onAction: () {
            // If Undo is clicked, notify the controller to restore data.
            ref
                .read(homeScreenControllerProvider.notifier)
                .undoDeleteCustomer(deleteCustomer, index);
          },
        );

        // Short delay to reset the 'lastDeleted' state so the listener doesn't fire again.
        Future.delayed(const Duration(milliseconds: 100), () {
          ref.read(homeScreenControllerProvider.notifier).clearLastDeleted();
        });
      }
    });
  }

  Future<void> _handleFabPressed() async {
    // Navigate to form and wait for result (newCustomer)
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddJobScreen()),
    );
  }
}
