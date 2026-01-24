import 'package:business_transactions/data/providers/repository_providers.dart';
import 'package:business_transactions/features/jobs/shared/glass_dialog.dart';
import 'package:business_transactions/models/customer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

class AddCustomerDialog extends ConsumerStatefulWidget {
  final String? initialName;
  const AddCustomerDialog({super.key, this.initialName});
  @override
  ConsumerState<AddCustomerDialog> createState() => _AddCustomerDialogState();
}

class _AddCustomerDialogState extends ConsumerState<AddCustomerDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.initialName);
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isSaving = true);
    try {
      final newCustomer = Customer(id: const Uuid().v4(), name: _nameController.text.trim(), vehicles: []);
      await ref.read(customerRepositoryProvider).saveCustomer(newCustomer);
      if (mounted) Navigator.pop(context, newCustomer);
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: $e")));
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GlassDialogShell(
      title: "New Customer",
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            GlassDialogTextField(controller: _nameController, label: "Customer Name", isRequired: true, autoFocus: true),
            const SizedBox(height: 32),
            GlassDialogButton(label: "Create Customer", isLoading: _isSaving, onPressed: _save),
          ],
        ),
      ),
    );
  }
}