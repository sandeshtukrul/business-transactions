import 'package:business_transactions/config/constants/string_const.dart';
import 'package:business_transactions/features/customers/screens/customer_details_screen.dart';
import 'package:business_transactions/features/home/controllers/home_controller.dart';
import 'package:business_transactions/features/home/widgets/customer_list_item.dart';
import 'package:business_transactions/features/home/widgets/empty_view.dart';
import 'package:business_transactions/features/transaction_form/screens/transaction_form_screen.dart';
import 'package:business_transactions/models/customer.dart';
import 'package:business_transactions/models/transaction.dart';
import 'package:business_transactions/shared/helpers/dialog_helper.dart';
import 'package:business_transactions/shared/helpers/snackbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomersTabContent extends ConsumerWidget {
  final List<Customer> customerData;

  const CustomersTabContent({
    super.key,
    required this.customerData,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (customerData.isEmpty) {
      return EmptyView(
        lottiePath: noCustomersLottiePath,
        title: noCustomersTitle,
        subtitle: addFirstCustomerHint,
        repeatable: true,
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16), // Add padding around the list
      itemCount: customerData.length,
      itemBuilder: (_, index) {
        final customer = customerData[index];
        return CustomerListItem(
          key: ValueKey(customer.id),
          customer: customer,
          onTap: () async {
            await _handleOnTap(context, customer, ref);
          },
          onSendReceiveTap: (updatedCustomer) =>
              _handleSendReceiveTap(context, updatedCustomer, ref),
          onEdit: () async {
            await _editCustomerName(context, customer, ref);
          },
          onDelete: () async {
            await _deleteCustomer(context, customer, index, ref);
          },
        );
      },
    );
  }

  Future<void> _deleteCustomer(BuildContext context, Customer customerToDelete,
      int index, WidgetRef ref) async {
    final bool confirmed = await DialogHelper.showConfirmDelete(
      context: context,
      title: deleteCustomerTitle,
      content: '$deleteConfirmContent "${customerToDelete.name}"$questionMark',
    );

    if (confirmed && context.mounted) {
      await ref
          .read(homeScreenControllerProvider.notifier)
          .deleteCustomer(customerToDelete);
    }
  }

  Future<void> _handleSendReceiveTap(
      BuildContext context, Customer customer, WidgetRef ref) async {
    final newTransaction = await Navigator.push<Transaction>(
        context,
        MaterialPageRoute(
          builder: (context) => TransactionForm(
            customer: customer,
          ),
        ));
    if (newTransaction != null) {
      final updatedCustomer = customer.copyWith(
        transactions: [...customer.transactions, newTransaction],
      );
      await ref
          .read(homeScreenControllerProvider.notifier)
          .updateCustomer(updatedCustomer);

      final message = '$newTransactionAdded "${updatedCustomer.name}"';

      if (!context.mounted) return;
      SnackbarHelper.showSuccess(context, message);
    }
  }

  Future<void> _handleOnTap(
      BuildContext context, Customer customer, WidgetRef ref) async {
    await Navigator.push<Customer>(
        context,
        MaterialPageRoute(
          builder: (context) => CustomerDetailsScreen(
            customerId: customer.id,
          ),
        ));
    if (context.mounted) {
      ref.invalidate(homeScreenControllerProvider);
    }
  }

  Future<void> _editCustomerName(
      BuildContext context, Customer customerToEdit, WidgetRef ref) async {
    final String? newName = await DialogHelper.showEditTextDialog(
      context: context,
      title: editCustomerNameTitle,
      labelText: customerNameLabel,
      initialName: customerToEdit.name,
    );

    if (newName != null &&
        newName.isNotEmpty &&
        newName != customerToEdit.name) {
      await ref
          .read(homeScreenControllerProvider.notifier)
          .updateCustomer(customerToEdit.copyWith(name: newName));
      if (!context.mounted) return;
      SnackbarHelper.showSuccess(
          context, '${customerToEdit.name} $updatedSuccessfully');
    }
  }
}
