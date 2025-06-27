import 'package:business_transactions/config/constants/string_const.dart';
import 'package:business_transactions/core/utils/formatters.dart';
import 'package:business_transactions/models/customer.dart';
import 'package:business_transactions/shared/widgets/list_item/base_list_card.dart';
import 'package:business_transactions/shared/widgets/list_item/date_time_info.dart';
import 'package:business_transactions/shared/widgets/list_item/list_tile_content.dart';
import 'package:business_transactions/shared/widgets/list_item/long_press_context_menu.dart';
import 'package:flutter/material.dart';

class CustomerListItem extends StatelessWidget {
  final VoidCallback onTap;
  final VoidCallback onDelete;
  final VoidCallback onEdit;
  final Function(Customer customer) onSendReceiveTap;
  final Customer customer;

  const CustomerListItem({
    super.key,
    required this.onTap,
    required this.onDelete,
    required this.onEdit,
    required this.onSendReceiveTap,
    required this.customer,
  });

  @override
  Widget build(BuildContext context) {
    return BaseListCard(
      onLongPress: (details) => LongPressContextMenu(
        context: context,
        details: details,
        onDelete: onDelete,
        onEdit: onEdit,
      ).show(),
      child: ListTileContent(
        title: customer.name,
        trailing: _TrailingAmount(currentBalance: customer.currentBalance),
        subtitle: _Subtitle(
          customer: customer,
          onSendReceiveTap: onSendReceiveTap,
        ),
        onTap: onTap,
      ),
    );
  }
}

class _TrailingAmount extends StatelessWidget {
  const _TrailingAmount({
    required this.currentBalance,
  });

  final int currentBalance;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final bool isNegative = currentBalance < 0;
    final Color amountColor =
        isNegative ? colorScheme.error : colorScheme.primary;

    return Text(Formatters.formatCurrency(currentBalance),
        style: textTheme.bodyLarge?.copyWith(
          fontWeight: FontWeight.bold,
          color: amountColor,
        ));
  }
}

class _Subtitle extends StatelessWidget {
  final Customer customer;
  final Function(Customer customer) onSendReceiveTap;

  const _Subtitle({
    required this.customer,
    required this.onSendReceiveTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DateTimeInfo(dateTimeText: Formatters.formatDate(customer.createdAt)),
        const SizedBox(height: 8),
        _SendAndReceiveButton(() => onSendReceiveTap(customer)),
      ],
    );
  }
}

class _SendAndReceiveButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _SendAndReceiveButton(this.onPressed);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return ActionChip(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      avatar: Icon(
        Icons.currency_rupee_outlined,
        size: 16,
        color: colorScheme.onPrimaryContainer,
      ),
      labelPadding: const EdgeInsets.only(left: 4, right: 4),
      label: Text(sendAndReceive),
      labelStyle: textTheme.labelLarge?.copyWith(
        color: colorScheme.onPrimaryContainer,
        fontWeight: FontWeight.bold,
      ),
      onPressed: onPressed,
      backgroundColor: colorScheme.primaryContainer.withValues(alpha: 0.7),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: colorScheme.primary.withValues(alpha: 0.3)),
      ),
    );
  }
}
