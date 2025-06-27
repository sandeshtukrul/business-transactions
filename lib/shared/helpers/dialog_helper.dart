import 'package:business_transactions/config/constants/string_const.dart';
import 'package:business_transactions/shared/widgets/form_title_field.dart';
import 'package:flutter/material.dart';

class DialogHelper {
  static Future<bool> showConfirmDelete({
    required BuildContext context,
    required String title,
    required String content,
  }) async {
    final bool? confirmed = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => _ConfirmDeleteDialog(
        title: title,
        content: content,
      ),
    );

    return confirmed ?? false;
  }

  static Future<String?> showEditTextDialog({
    required BuildContext context,
    required String title,
    required String labelText,
    required String initialName,
    IconData? icon = Icons.person,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => _EditTextDialog(
        title: title,
        initialName: initialName,
        labelText: labelText,
        icon: icon!,
      ),
    );
  }
}

class _ConfirmDeleteDialog extends StatelessWidget {
  final String title;
  final String content;

  const _ConfirmDeleteDialog({
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return AlertDialog(
      icon:
          Icon(Icons.warning_amber_rounded, color: colorScheme.error, size: 28),
      title: Text(title),
      content: Text(content),
      actions: <Widget>[
        TextButton(
          style: TextButton.styleFrom(
            foregroundColor: colorScheme.error,
          ),
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(cancelButton),
        ),
        FilledButton(
          style: FilledButton.styleFrom(
            backgroundColor: colorScheme.error,
            foregroundColor: colorScheme.onError,
          ),
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(deleteButton),
        )
      ],
    );
  }
}

class _EditTextDialog extends StatefulWidget {
  final String title;
  final String labelText;
  final String initialName;
  final IconData icon;

  const _EditTextDialog({
    required this.title,
    required this.initialName,
    required this.labelText,
    required this.icon,
  });

  @override
  State<_EditTextDialog> createState() => _EditTextDialogState();
}

class _EditTextDialogState extends State<_EditTextDialog> {
  late TextEditingController _textController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(text: widget.initialName);
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _submitText() {
    if (_formKey.currentState?.validate() ?? false) {
      Navigator.of(context).pop(_textController.text.trim());
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: Form(
          key: _formKey,
          child: FormTitleField(
            controller: _textController,
            labelText: widget.labelText,
            icon: widget.icon,
          )),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text(cancelButton),
        ),
        FilledButton(
          onPressed: _submitText,
          child: const Text(saveButton),
        ),
      ],
    );
  }
}
