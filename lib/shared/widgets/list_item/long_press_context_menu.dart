import 'package:business_transactions/config/constants/string_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum LongPressAction { edit, delete }

class LongPressContextMenu {
  final BuildContext context;
  final LongPressStartDetails details;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const LongPressContextMenu({
    required this.context,
    required this.details,
    this.onEdit,
    this.onDelete,
  });

  void show() {
    HapticFeedback.mediumImpact();

    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;
    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(details.globalPosition, details.globalPosition),
      Offset.zero & overlay.size,
    );

    showMenu<LongPressAction>(
      context: context,
      position: position,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      color: Theme.of(context).colorScheme.surfaceContainerLowest,
      items: <PopupMenuEntry<LongPressAction>>[
        if (onEdit != null)
          PopupMenuItem<LongPressAction>(
            value: LongPressAction.edit,
            child: _buildMenuItem(
              icon: Icons.edit_outlined,
              label: editButton,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        if (onDelete != null)
          PopupMenuItem<LongPressAction>(
            value: LongPressAction.delete,
            child: _buildMenuItem(
              icon: Icons.delete_outline,
              label: deleteButton,
              color: Theme.of(context).colorScheme.error,
            ),
          ),
      ],
    ).then((LongPressAction? selectedAction) {
      switch (selectedAction) {
        case LongPressAction.edit:
          onEdit?.call();
          break;
        case LongPressAction.delete:
          onDelete?.call();
          break;
        case null:
          break;
      }
    });
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String label,
    required Color color,
  }) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        Icon(icon, size: 20, color: color),
        const SizedBox(width: 12),
        Text(label, style: textTheme.bodyMedium?.copyWith(color: color)),
      ],
    );
  }
}
