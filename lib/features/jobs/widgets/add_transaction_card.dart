import 'package:business_transactions/config/glass_theme.dart';
import 'package:business_transactions/features/jobs/controllers/add_job_controller.dart';
import 'package:business_transactions/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddTransactionCard extends ConsumerStatefulWidget {
  const AddTransactionCard({super.key});

  @override
  ConsumerState<AddTransactionCard> createState() => _AddTransactionCardState();
}

class _AddTransactionCardState extends ConsumerState<AddTransactionCard> {
  final _amountController = TextEditingController();

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(addJobControllerProvider);
    final controller = ref.read(addJobControllerProvider.notifier);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final isSubmitting = state.isSubmitting;

    final labelStyle = TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: isDark ? GlassColors.textLight : GlassColors.textDark);
    final subStyle = TextStyle(fontSize: 13, color: GlassColors.textSubtle);
    final inputTextStyle = TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: isDark ? GlassColors.textLight : GlassColors.textDark);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      decoration: _glassDecoration(context),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. TOGGLE
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Advance Payment", style: labelStyle),
                  Text("Record initial deposit", style: subStyle),
                ],
              ),
              Switch.adaptive(
                value: state.isAdvancePayment,
                activeColor: Theme.of(context).colorScheme.primary,
                onChanged: isSubmitting
                    ? null
                    : (val) => controller.toggleAdvancePayment(val),
              ),
            ],
          ),

          // 2. FORM
          if (state.isAdvancePayment) ...[
            const SizedBox(height: 20),
            const Divider(height: 1),
            const SizedBox(height: 20),

            // A. AMOUNT INPUT
            Text("Amount Received",
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: GlassColors.textSubtle)),
            const SizedBox(height: 8),
            _glassInputContainer(
              context,
              child: Row(
                children: [
                  Text("₹",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : Colors.black)),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      controller: _amountController,
                      enabled: !isSubmitting,
                      scrollPadding: const EdgeInsets.only(bottom: 110),
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          isDense: true,
                          hintText: "0.00"),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^\d+\.?\d{0,2}'))
                      ],
                      onChanged: (val) {
                        controller.setAdvanceAmount(
                            val.isEmpty ? 0.0 : double.tryParse(val) ?? 0.0);
                      },
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // B. PAYMENT METHOD DROPDOWN
            Text("Payment Mode",
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: GlassColors.textSubtle)),
            const SizedBox(height: 8),

            _glassInputContainer(
              context,
              // DropdownButtonHideUnderline removes the ugly default line
              child: DropdownButtonHideUnderline(
                child: DropdownButton<PaymentMethod>(
                  value: state.paymentMode,
                  isDense: true,
                  icon: Icon(Icons.keyboard_arrow_down,
                      color: GlassColors.textSubtle),
                  dropdownColor:
                      isDark ? const Color(0xFF1E1E1E) : Colors.white,
                  style: inputTextStyle,
                  borderRadius: BorderRadius.circular(12),
                  items: PaymentMethod.values.map((mode) {
                    return DropdownMenuItem(
                      value: mode,
                      child: Row(
                        children: [
                          Icon(_getIconForMode(mode),
                              size: 18,
                              color: Theme.of(context).colorScheme.primary),
                          const SizedBox(width: 12),
                          Text(_getLabelForMode(mode)),
                        ],
                      ),
                    );
                  }).toList(),
                  onChanged: isSubmitting
                      ? null
                      : (PaymentMethod? newValue) {
                          if (newValue != null) {
                            controller.setPaymentMode(newValue);
                          }
                        },
                ),
              ),
            ),
          ]
        ],
      ),
    );
  }

  // --- HELPERS FOR DISPLAY ---
  String _getLabelForMode(PaymentMethod mode) {
    switch (mode) {
      case PaymentMethod.upi:
        return "GPay / UPI";
      case PaymentMethod.cash:
        return "Cash";
      case PaymentMethod.bank:
        return "Bank Transfer";
      case PaymentMethod.other:
        return "Other";
    }
  }

  IconData _getIconForMode(PaymentMethod mode) {
    switch (mode) {
      case PaymentMethod.upi:
        return Icons.qr_code;
      case PaymentMethod.cash:
        return Icons.money;
      case PaymentMethod.bank:
        return Icons.account_balance;
      case PaymentMethod.other:
        return Icons.more_horiz;
    }
  }

  // --- STYLING HELPERS ---
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

  Widget _glassInputContainer(BuildContext context, {required Widget child}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: double.infinity, // Ensure dropdown takes full width
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: isDark ? GlassColors.inputFillDark : GlassColors.inputFillLight,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
            color: isDark
                ? GlassColors.inputBorderDark
                : GlassColors.inputBorderLight),
      ),
      child: child,
    );
  }
}
