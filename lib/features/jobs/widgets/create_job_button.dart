import 'package:business_transactions/features/jobs/controllers/add_job_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreateJobButton extends ConsumerStatefulWidget {
  const CreateJobButton({super.key});

  @override
  ConsumerState<CreateJobButton> createState() => _CreateJobButtonState();
}

class _CreateJobButtonState extends ConsumerState<CreateJobButton> {
  
  Future<void> _handlePress() async {
    // 1. Close Keyboard
    FocusManager.instance.primaryFocus?.unfocus();

    // 2. Submit via Controller
    final controller = ref.read(addJobControllerProvider.notifier);
    // Call submitJob. It returns "SUCCESS", "Error String", or NULL (if validation failed)
    final result = await controller.submitJob();

    if (!mounted) return;

    if (result == "SUCCESS") {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: const Text("Job Created Successfully!"), behavior: SnackBarBehavior.floating),
      );
      Navigator.pop(context);
    } else if (result != null) {
      // Real Database Error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result), behavior: SnackBarBehavior.floating),
      );
    } 
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(addJobControllerProvider);
    final theme = Theme.of(context);

    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton.icon(
        onPressed: state.isSubmitting ? null : _handlePress,
        style: ElevatedButton.styleFrom(
          backgroundColor: theme.colorScheme.primary,
          foregroundColor: theme.colorScheme.onPrimary,
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        icon: state.isSubmitting
            ? SizedBox(
                width: 20, 
                height: 20, 
                child: CircularProgressIndicator(color: theme.colorScheme.onPrimary, strokeWidth: 2.5)
              )
            : const Icon(Icons.check_circle, size: 24),
        label: Text(
          state.isSubmitting ? "SAVING..." : "CREATE JOB",
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, letterSpacing: 1.0),
        ),
      ),
    );
  }
}