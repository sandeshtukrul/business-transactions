import 'package:business_transactions/config/constants/string_const.dart';
import 'package:business_transactions/core/utils/formatters.dart';
import 'package:business_transactions/features/transaction_form/controllers/transaction_form_controller.dart';
import 'package:business_transactions/features/transaction_form/state/transaction_form_state.dart';
import 'package:business_transactions/features/transaction_form/widgets/customer_details_section.dart';
import 'package:business_transactions/features/transaction_form/widgets/form_save_button.dart';
import 'package:business_transactions/features/transaction_form/widgets/transaction_details_section.dart';
import 'package:business_transactions/models/customer.dart';
import 'package:business_transactions/models/transaction.dart';
import 'package:business_transactions/shared/helpers/snackbar_helper.dart';
import 'package:business_transactions/shared/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TransactionForm extends ConsumerStatefulWidget {
  final Customer? customer;
  final Transaction? transaction;

  const TransactionForm({
    super.key,
    this.customer,
    this.transaction,
  });

  @override
  ConsumerState<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends ConsumerState<TransactionForm> {
  final _formKey = GlobalKey<FormState>();

  final _customerNameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _amountController = TextEditingController();
  final _partyNameController = TextEditingController();

  @override
  void initState() {
    super.initState();

    final initialState = ref.read(transactionFormControllerProvider(
      customer: widget.customer,
      transaction: widget.transaction,
    ));

    _customerNameController.text = widget.customer?.name ?? '';
    _partyNameController.text =
        initialState.initialTransaction?.partyName ?? '';
    _descriptionController.text =
        initialState.initialTransaction?.description ?? '';
    _amountController.text = initialState.initialTransaction != null
        ? Formatters.getAmountInRupeeString(
            initialState.initialTransaction!.amount)
        : '';
  }

  @override
  void dispose() {
    _customerNameController.dispose();
    _partyNameController.dispose();
    _descriptionController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      ref
          .read(transactionFormControllerProvider(
            customer: widget.customer,
            transaction: widget.transaction,
          ).notifier)
          .submitForm(
            customerName: _customerNameController.text,
            partyName: _partyNameController.text,
            amount: _amountController.text,
            description: _descriptionController.text,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final formProvider = transactionFormControllerProvider(
      customer: widget.customer,
      transaction: widget.transaction,
    );

    final formState = ref.watch(formProvider);

    final formController = ref.read(formProvider.notifier);

    ref.listen(formProvider.select((state) => state.status), (previous, next) {
      if (next == FormStatus.success) {
        Navigator.of(context).pop(ref.read(formProvider).result);
      } else if (next == FormStatus.error) {
        SnackbarHelper.showError(context, formSaveError);
      }
    });

    final isCustomerFieldReadOnly = formState.mode != FormMode.addCustomer;

    return Scaffold(
      appBar: CustomAppBar(title: formState.appBarTitle),
      body: Padding(
        // Outer horizontal padding
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: ListView(
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomerDetailsSection(
                                isReadOnly: isCustomerFieldReadOnly,
                                controller: _customerNameController),
                            const SizedBox(height: 18),
                            TransactionDetailsSection(
                              amountController: _amountController,
                              partyNameController: _partyNameController,
                              descriptionController: _descriptionController,
                              formController: formController,
                              formState: formState,
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 18),
              FormSaveButton(
                onPressed: formState.status == FormStatus.submitting
                    ? null
                    : _submitForm,
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
