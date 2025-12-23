import 'package:business_transactions/config/constants/string_const.dart';
import 'package:business_transactions/core/utils/formatters.dart';
import 'package:business_transactions/models/transaction.dart';
import 'package:business_transactions/shared/widgets/list_item/base_list_card.dart';
import 'package:business_transactions/shared/widgets/list_item/date_time_info.dart';
import 'package:business_transactions/shared/widgets/list_item/list_tile_content.dart';
import 'package:flutter/material.dart';


/// Displays a single transaction card with date, amount, and description.
class TransactionListItem extends StatelessWidget {
  final VoidCallback onTap;
  final VoidCallback onDelete;
  final Transaction transaction;

  const TransactionListItem({
    super.key,
    required this.onTap,
    required this.transaction,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return BaseListCard(
      onLongPress: (_) => onDelete(),
      child: ListTileContent(
        title: transaction.partyName,
        trailing: _TrailingAmount(transaction: transaction),
        subtitle: _Subtitle(transaction: transaction),
        onTap: onTap,
      ),
    );
  }
}

class _TrailingAmount extends StatelessWidget {
  const _TrailingAmount({
    required this.transaction,
  });

  final Transaction transaction;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final bool isSent = transaction.type == TransactionType.sent;
    final amountColor = isSent ? colorScheme.error : colorScheme.primary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
            Formatters.formatTransactionAmount(
                transaction.amount, transaction.type),
            style: textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: amountColor,
            )),
        const SizedBox(height: 4),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.qr_code_scanner, size: 10, color: colorScheme.tertiary),
            const SizedBox(width: 4),
            Text(
              transaction.paymentMethod,
              style:
                  textTheme.labelSmall?.copyWith(color: colorScheme.tertiary),
            ),
          ],
        )
      ],
    );
  }
}

class _Subtitle extends StatelessWidget {
  final Transaction transaction;

  const _Subtitle({required this.transaction});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final bool hasDescription =
        transaction.description != null && transaction.description!.isNotEmpty;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          hasDescription ? transaction.description! : noDescription,
          style: textTheme.bodySmall,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 4),
        DateTimeInfo(
            dateTimeText: Formatters.formatDateTime(transaction.createdAt))
      ],
    );
  }
}
