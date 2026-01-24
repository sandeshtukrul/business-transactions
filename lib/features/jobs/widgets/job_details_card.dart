import 'package:business_transactions/config/glass_theme.dart';
import 'package:business_transactions/features/jobs/controllers/add_job_controller.dart';
import 'package:business_transactions/features/transaction_form/widgets/date_time_picker_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class JobDetailsCard extends ConsumerStatefulWidget {
  const JobDetailsCard({super.key});

  @override
  ConsumerState<JobDetailsCard> createState() => _JobDetailsCardState();
}

class _JobDetailsCardState extends ConsumerState<JobDetailsCard> {
  late TextEditingController _titleController;
  late TextEditingController _amountController;

  @override
  void initState() {
    super.initState();
    final state = ref.read(addJobControllerProvider);
    _titleController = TextEditingController(text: state.jobTitle);
    _amountController = TextEditingController(
      text: state.estimatedAmount > 0 ? state.estimatedAmount.toString() : '',
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Listen to state changes (mostly for the Date Picker)
    final state = ref.watch(addJobControllerProvider);
    final controller = ref.read(addJobControllerProvider.notifier);

    final isSubmitting = state.isSubmitting;

    // --- VALIDATION LOGIC ---
    // Error if: Submitted AND Title is empty
    final titleErrorText =
        (state.showFormErrors && state.jobTitle.trim().isEmpty)
            ? "Required"
            : null;

    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Styling constants
    final labelStyle = TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: GlassColors.textSubtle);
    final inputTextStyle = TextStyle(
      fontSize: 16,
      color: isDark ? GlassColors.textLight : GlassColors.textDark,
      fontWeight: FontWeight.w500,
    );
    final hintStyle =
        TextStyle(color: GlassColors.textSubtle.withValues(alpha: 0.5));

    return Container(
      decoration: _glassDecoration(context),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ==============================
          // 1. JOB TITLE
          // ==============================
          Text("Job Title", style: labelStyle),
          const SizedBox(height: 8),

          _glassInputContainer(
            context,
            hasError: titleErrorText != null,
            child: TextField(
              controller: _titleController,
              enabled: !isSubmitting,
              scrollPadding: const EdgeInsets.only(bottom: 110),
              style: inputTextStyle.copyWith(color: isSubmitting ? GlassColors.textSubtle : null),
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
                hintText: "e.g. Full Service, Oil Change",
                hintStyle: hintStyle,
              ),
              onChanged: (val) => controller.setJobTitle(val),
            ),
          ),
          // Show error text below container if needed
          if (titleErrorText != null)
            Padding(
              padding: const EdgeInsets.only(top: 4, left: 4),
              child: Text(titleErrorText,
                  style:
                      const TextStyle(color: Colors.redAccent, fontSize: 12)),
            ),

          const SizedBox(height: 24),

          // ==============================
          // 2. ESTIMATED AMOUNT
          // ==============================
          Text("Est. Amount", style: labelStyle),
          const SizedBox(height: 8),

          _glassInputContainer(
            context,
            child: Row(
              children: [
                Text("₹",
                    style:
                        inputTextStyle.copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: _amountController,
                    enabled: !isSubmitting,
                    scrollPadding: const EdgeInsets.only(bottom: 110),
                    style: inputTextStyle.copyWith(fontWeight: FontWeight.bold),
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp(r'^\d+\.?\d{0,2}')), // Allow decimals
                    ],
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                      hintText: "0.00",
                      hintStyle: hintStyle,
                    ),
                    onChanged: (val) {
                      if (val.isEmpty) {
                        controller.setEstimatedAmount(null);
                      } else {
                        final double? amount = double.tryParse(val);
                        if (amount != null) {
                          controller.setEstimatedAmount(amount);
                        }
                      }
                    },
                  ),
                ),
                // Optional: An icon to indicate this is an estimate
                Icon(Icons.calculate_outlined,
                    color: GlassColors.textSubtle, size: 20),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // ==============================
          // 3. DATE PICKER (Your Custom Widget)
          // ==============================
          // We pass the current state date and the function to update it
          DateTimePickerRow(
            selectedDateTime: state.selectedDate,
            onDateTimeChanged: isSubmitting
            ? (date) {}
            : (newDate) => controller.selectDate(newDate),
            buttonText: "Change",
          ),
        ],
      ),
    );
  }

  // --- STYLING HELPERS (Reused from Customer Card for consistency) ---
  BoxDecoration _glassDecoration(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return BoxDecoration(
      color: isDark ? GlassColors.glassPanelDark : GlassColors.glassPanelLight,
      borderRadius: BorderRadius.circular(20),
      border: Border.all(
          color: isDark
              ? GlassColors.glassBorderDark
              : GlassColors.glassBorderLight),
    );
  }

  Widget _glassInputContainer(BuildContext context,
      {required Widget child, bool hasError = false}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: isDark ? GlassColors.inputFillDark : GlassColors.inputFillLight,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: hasError
              ? Colors.redAccent.withOpacity(0.8)
              : (isDark
                  ? GlassColors.inputBorderDark
                  : GlassColors.inputBorderLight),
          width: hasError ? 1.5 : 1.0,
        ),
      ),
      child: child,
    );
  }
}
