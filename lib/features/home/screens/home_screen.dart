import 'package:business_transactions/config/constants/string_const.dart';
import 'package:business_transactions/core/utils/formatters.dart';
import 'package:business_transactions/features/home/controllers/home_controller.dart';
import 'package:business_transactions/features/home/states/home_state.dart';
import 'package:business_transactions/features/home/widgets/customers_tab_content.dart';
import 'package:business_transactions/features/home/widgets/error_view.dart';
import 'package:business_transactions/features/home/widgets/home_app_bar.dart';
import 'package:business_transactions/features/home/widgets/home_fab.dart';
import 'package:business_transactions/features/transaction_form/screens/transaction_form_screen.dart';
import 'package:business_transactions/models/customer.dart';
import 'package:business_transactions/shared/helpers/snackbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
            ref
                .read(homeScreenControllerProvider.notifier)
                .undoDeleteCustomer(deleteCustomer, index);
          },
        );

        Future.delayed(const Duration(milliseconds: 100), () {
          ref.read(homeScreenControllerProvider.notifier).clearLastDeleted();
        });
      }
    });

    final homeAsyncState = ref.watch(homeScreenControllerProvider);
    final currentUsername = ref.watch(usernameProvider);

    return Scaffold(
      floatingActionButton: FabManager(
        tabController: _tabController,
        onPressed: _handleFabPressed,
      ),
      appBar: homeAsyncState.when(
        loading: () => HomeAppBar(
          username: guestUsername,
          balanceValue: zeroBalance,
          tabController: _tabController,
        ),
        error: (err, stack) => AppBar(
          title: const Text(errorTitle),
        ),
        data: (homeState) => HomeAppBar(
          username: currentUsername,
          balanceValue: Formatters.formatCurrency(homeState.totalBalance),
          tabController: _tabController,
        ),
      ),
      body: homeAsyncState.when(
          data: (homeState) {
            return _buildSuccessUI(homeState);
          },
          error: (err, stack) => ErrorView(
              error: err,
              stackTrace: stack,
              onRetry: () => ref.invalidate(homeScreenControllerProvider)),
          loading: () {
            final previousStateData = ref.watch(homeScreenControllerProvider
                .select((asyncValue) => asyncValue.valueOrNull));

            if (previousStateData != null) {
              return Stack(
                children: [
                  Opacity(
                      opacity: 0.5, child: _buildSuccessUI(previousStateData)),
                  const Center(child: CircularProgressIndicator())
                ],
              );
            }
            return const Center(child: CircularProgressIndicator());
          }),
    );
  }

  Future<void> _handleFabPressed() async {
    final newCustomer = await Navigator.push<Customer>(
      context,
      MaterialPageRoute(builder: (context) => const TransactionForm()),
    );

    if (newCustomer != null) {
      await ref
          .read(homeScreenControllerProvider.notifier)
          .addCustomer(newCustomer);

      if (!mounted) return;
      SnackbarHelper.showSuccess(
          context, '"${newCustomer.name}" $addedSuccessfully');
    }
  }

  Widget _buildSuccessUI(HomeState homeState) {
    return TabBarView(
      controller: _tabController,
      children: [
        CustomersTabContent(customerData: homeState.customers),
        Center(child: Text('This is the Vendors tab')),
        Center(child: Text('This is the History tab'))
      ],
    );
  }
}
