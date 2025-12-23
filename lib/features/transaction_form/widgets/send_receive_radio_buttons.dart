import 'package:business_transactions/config/constants/string_const.dart';
import 'package:business_transactions/models/transaction.dart';
import 'package:flutter/material.dart';

/// A widget that displays two Radio Buttons for selecting the Transaction Type.
class SendReceiveRadioButtons extends StatelessWidget {
  final TransactionType transactionType;
  final ValueChanged<TransactionType?> onChanged;

  const SendReceiveRadioButtons({
    super.key,
    required this.transactionType,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(transactionTypeLabel,
            style: textTheme.labelLarge?.copyWith(
              color: colorScheme.onSurfaceVariant,
              ),
            ),
        RadioGroup<TransactionType>(
          groupValue: transactionType,
          onChanged: onChanged,
          child: Row(
          children: <Widget>[
            Expanded(
              child: RadioListTile<TransactionType>(
                title: const Text(send),
                value: TransactionType.sent,
                contentPadding: EdgeInsets.zero,
                visualDensity: VisualDensity.compact,
                activeColor: colorScheme.primary,
              ),
            ),
            Expanded(
              child: RadioListTile<TransactionType>(
                title: const Text(receive),
                value: TransactionType.received,
                contentPadding: EdgeInsets.zero,
                visualDensity: VisualDensity.compact,
                activeColor: colorScheme.primary,
              ),
            ),
          ],
        ),
        )
      ],
    );
  }
}
