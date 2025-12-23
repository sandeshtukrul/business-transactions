import 'package:business_transactions/config/constants/string_const.dart';
import 'package:business_transactions/features/transaction_form/controllers/transaction_form_controller.dart';
import 'package:business_transactions/features/transaction_form/state/transaction_form_state.dart';
import 'package:business_transactions/features/transaction_form/widgets/date_time_picker_row.dart';
import 'package:business_transactions/features/transaction_form/widgets/form_amount_field.dart';
import 'package:business_transactions/features/transaction_form/widgets/form_description_field.dart';
import 'package:business_transactions/features/transaction_form/widgets/form_section.dart';
import 'package:business_transactions/features/transaction_form/widgets/payment_method_dropdown.dart';
import 'package:business_transactions/features/transaction_form/widgets/send_receive_radio_buttons.dart';
import 'package:business_transactions/shared/widgets/form_title_field.dart';
import 'package:flutter/material.dart';

/// Grouping widget for all transaction-specific fields.
class TransactionDetailsSection extends StatelessWidget {
  final TextEditingController amountController;
  final TextEditingController partyNameController;
  final TextEditingController descriptionController;
  final TransactionFormController formController;
  final TransactionFormState formState;

  const TransactionDetailsSection(
      {super.key,
      required this.amountController,
      required this.partyNameController,
      required this.descriptionController,
      required this.formController,
      required this.formState});

  @override
  Widget build(BuildContext context) {
    final String dateTimeButtonText =
        formState.mode == FormMode.updateTransaction ? editButton : setButton;

    return FormSection(
        title: transactionDetailsLabel,
        icon: Icons.price_change_outlined,
        children: [
          FormTitleField(
            controller: partyNameController,
            labelText: partyNameLabel,
            icon: Icons.storefront_outlined,
          ),
          SendReceiveRadioButtons(
            transactionType: formState.transactionType,
            onChanged: (value) => formController.setTransactionType(value!),
          ),
          FormAmountField(controller: amountController),
          PaymentMethodDropdown(
            paymentMethods: paymentMethods,
            selectedPaymentMethod: formState.selectedPaymentMethod,
            onChanged: (value) => formController.setPaymentMethod(value),
          ),
          FormDescriptionField(controller: descriptionController),
          DateTimePickerRow(
            selectedDateTime: formState.selectedDateTime!,
            onDateTimeChanged: (value) => formController.setDateTime(value),
            buttonText: dateTimeButtonText,
          ),
        ]);
  }
}
