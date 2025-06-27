import 'package:business_transactions/config/constants/string_const.dart';
import 'package:business_transactions/features/customers/controllers/customer_details_controller.dart';
import 'package:business_transactions/features/customers/widgets/transactions_list_view.dart';
import 'package:business_transactions/features/home/widgets/error_view.dart';
import 'package:business_transactions/features/home/widgets/home_fab.dart';
import 'package:business_transactions/features/transaction_form/screens/transaction_form_screen.dart';
import 'package:business_transactions/models/transaction.dart';
import 'package:business_transactions/shared/helpers/snackbar_helper.dart';
import 'package:business_transactions/shared/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomerDetailsScreen extends ConsumerWidget {
  final String customerId;

  const CustomerDetailsScreen({super.key, required this.customerId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(
        customerDetailsControllerProvider(customerId)
            .select((state) => state.valueOrNull?.lastDeletedTransaction),
        (previous, next) {
      if (next != null) {
        final (deletedTransaction, index) = next;
        SnackbarHelper.showSuccess(
            context, '"${deletedTransaction.partyName}" $deletedSuccessfully,',
            onAction: () {
          ref
              .read(customerDetailsControllerProvider(customerId).notifier)
              .undoDeleteTransaction();

          Future.delayed(const Duration(milliseconds: 100), () {
            ref
                .read(customerDetailsControllerProvider(customerId).notifier)
                .clearLastDeleted();
          });
        });
      }
    });

    final asyncState = ref.watch(customerDetailsControllerProvider(customerId));

    return Scaffold(
      floatingActionButton: MyFab(onPressed: () async {
        if (asyncState.valueOrNull?.customer == null) {
          return; // Don't proceed if no customer data
        }

        final newTransaction = await Navigator.push<Transaction>(
          context,
          MaterialPageRoute(
            builder: (context) =>
                TransactionForm(customer: asyncState.valueOrNull?.customer),
          ),
        );

        if (newTransaction != null && context.mounted) {
          await ref
              .read(customerDetailsControllerProvider(customerId).notifier)
              .addTransaction(newTransaction);
        }
      }),
      appBar: CustomAppBar(
        title: asyncState.when(
          data: (state) => customerDetailsTitle,
          error: (error, stackTrace) => errorTitle,
          loading: () => loadingText,
        ),
        onBack: () {
          Navigator.of(context).pop();
        },
      ),
      body: asyncState.when(
        data: (detailsState) {
          return TransactionListView(customer: detailsState.customer!);
        },
        error: (error, stackTrace) => ErrorView(
          error: error,
          stackTrace: stackTrace,
          onRetry: () =>
              ref.invalidate(customerDetailsControllerProvider(customerId)),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
