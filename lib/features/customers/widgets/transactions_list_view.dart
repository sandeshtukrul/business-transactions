import 'package:business_transactions/config/constants/string_const.dart';
import 'package:business_transactions/features/customers/controllers/customer_details_controller.dart';
import 'package:business_transactions/features/customers/widgets/transaction_list_item.dart';
import 'package:business_transactions/features/home/widgets/empty_view.dart';
import 'package:business_transactions/features/transaction_form/screens/transaction_form_screen.dart';
import 'package:business_transactions/models/customer.dart';
import 'package:business_transactions/models/transaction.dart';
import 'package:business_transactions/shared/helpers/dialog_helper.dart';
import 'package:business_transactions/shared/helpers/snackbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TransactionListView extends ConsumerWidget {
  final Customer customer;

  const TransactionListView({super.key, required this.customer});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (customer.transactions.isEmpty) {
      return EmptyView(
        lottiePath: noTransactionsLottiePath,
        title: noTransactionsTitle,
        subtitle: noTransactionsFoundHint,
      );
    }

    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: customer.transactions.length,
      itemBuilder: (_, index) {
        final transaction = customer.transactions[index];
        return TransactionListItem(
          key: ValueKey(transaction.id),
          onTap: () async {
            final updatedTransaction = await Navigator.push<Transaction>(
                context,
                MaterialPageRoute(
                    builder: (context) => TransactionForm(
                          customer: customer,
                          transaction: transaction,
                        )));

            if (updatedTransaction != null) {
              await ref
                  .read(customerDetailsControllerProvider(customer.id).notifier)
                  .updateTransaction(updatedTransaction);

              if (!context.mounted) return;
              SnackbarHelper.showSuccess(context,
                  '"${updatedTransaction.partyName}" $updatedSuccessfully');
            }
          },
          onDelete: () async {
            final bool confirmed = await DialogHelper.showConfirmDelete(
              context: context,
              title: deleteTransactionTitle,
              content:
                  '$deleteConfirmContent "${transaction.partyName}"$questionMark',
            );

            if (confirmed) {
              await ref
                  .read(customerDetailsControllerProvider(customer.id).notifier)
                  .deleteTransaciton(transaction);
            }
          },
          transaction: transaction,
        );
      },
    );
  }
}
