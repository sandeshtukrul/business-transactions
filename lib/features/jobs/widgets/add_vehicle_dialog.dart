import 'package:business_transactions/data/providers/repository_providers.dart';
import 'package:business_transactions/features/jobs/shared/glass_dialog.dart';
import 'package:business_transactions/models/customer.dart';
import 'package:business_transactions/models/vehicle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

class AddVehicleDialog extends ConsumerStatefulWidget {
  final Customer customer;
  final String? initialValue;
  const AddVehicleDialog({super.key, required this.customer, this.initialValue});
  @override
  ConsumerState<AddVehicleDialog> createState() => _AddVehicleDialogState();
}

class _AddVehicleDialogState extends ConsumerState<AddVehicleDialog> {
  final _formKey = GlobalKey<FormState>();
  final _modelController = TextEditingController();
  final _numberController = TextEditingController();
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    if (widget.initialValue != null && widget.initialValue!.isNotEmpty) {
       if (widget.initialValue!.contains(RegExp(r'[0-9]'))) {
         _numberController.text = widget.initialValue!;
       } else {
         _modelController.text = widget.initialValue!;
       }
    }
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isSaving = true);
    try {
      final vNum = _numberController.text.trim().toUpperCase();
      final newVehicle = Vehicle(id: const Uuid().v4(), name: _modelController.text.trim(), number: vNum.isEmpty ? null : vNum);
      final updatedCustomer = widget.customer.copyWith(vehicles: [...widget.customer.vehicles, newVehicle]);
      await ref.read(customerRepositoryProvider).saveCustomer(updatedCustomer);
      if (mounted) Navigator.pop(context, newVehicle);
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: $e")));
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GlassDialogShell(
      title: "Add Vehicle",
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            GlassDialogTextField(controller: _modelController, label: "Vehicle Model", hint: "e.g. Swift", isRequired: true, autoFocus: _modelController.text.isEmpty),
            const SizedBox(height: 16),
            GlassDialogTextField(controller: _numberController, label: "Vehicle Number", hint: "e.g. MH 12 AB 1234", textCapitalization: TextCapitalization.characters),
            const SizedBox(height: 32),
            GlassDialogButton(label: "Save Vehicle", isLoading: _isSaving, onPressed: _save),
          ],
        ),
      ),
    );
  }
}