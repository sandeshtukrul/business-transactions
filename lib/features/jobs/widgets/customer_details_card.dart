import 'package:business_transactions/config/glass_theme.dart';
import 'package:business_transactions/models/customer.dart';
import 'package:business_transactions/models/vehicle.dart';
import 'package:business_transactions/features/jobs/controllers/add_job_controller.dart';
import 'package:business_transactions/features/jobs/widgets/add_customer_dialog.dart';
import 'package:business_transactions/features/jobs/widgets/add_vehicle_dialog.dart';
import 'package:business_transactions/features/jobs/widgets/customer_search_sheet.dart';
import 'package:business_transactions/features/jobs/widgets/vehicle_search_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomerDetailsCard extends ConsumerWidget {
  const CustomerDetailsCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 1. Watch the specific state we need
    final state = ref.watch(addJobControllerProvider);
    final controller = ref.read(addJobControllerProvider.notifier);

    final isSubmitting = state.isSubmitting;

    // 2. Watch the customer list from DB
    final customersAsync = ref.watch(allCustomersProvider);

    final titleErrorText = "Required";

    final errorTextStyle = const TextStyle(
        color: Colors.redAccent, fontSize: 12, fontWeight: FontWeight.bold);

    final isDark = Theme.of(context).brightness == Brightness.dark;

    // --- VALIDATION LOGIC ---
    // Error if: We tried to submit AND customer is null
    final bool customerError =
        state.showFormErrors && state.selectedCustomer == null;
    // Error if: We tried to submit AND vehicle is null
    final bool vehicleError =
        state.showFormErrors && state.selectedVehicle == null;

    final labelStyle = TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: GlassColors.textSubtle);
    final valueStyle = TextStyle(
      fontSize: 16,
      color: isDark ? GlassColors.textLight : GlassColors.textDark,
      fontWeight: FontWeight.w500,
    );
    final placeholderStyle = TextStyle(
      fontSize: 16,
      color: GlassColors.textSubtle,
    );

    return Container(
      decoration: _glassDecoration(context),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ==============================
          // 1. CUSTOMER SELECTION
          // ==============================

          Text("Customer Name", style: labelStyle),

          const SizedBox(height: 8),

          InkWell(
            onTap: isSubmitting
                ? null
                : () {
                    customersAsync.whenData((customers) {
                      _showCustomerSearchSheet(context, customers, controller);
                    });
                  },
            child: _glassInputContainer(
              context,
              hasError: customerError,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    state.selectedCustomer?.name ?? "Select Customer",
                    style: state.selectedCustomer != null
                        ? valueStyle
                        : placeholderStyle,
                  ),
                  Icon(Icons.keyboard_arrow_down,
                      color: isSubmitting
                          ? Colors.grey.withValues(alpha: 0.3)
                          : GlassColors.textSubtle),
                ],
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 4, left: 4),
            child: customerError
                ? Text(titleErrorText, style: errorTextStyle)
                : SizedBox(),
          ),

          const SizedBox(height: 24),

          // ==============================
          // 2. VEHICLE SELECTION
          // ==============================
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Vehicle", style: labelStyle),
            ],
          ),
          const SizedBox(height: 8),

          InkWell(
            onTap: isSubmitting
                ? null
                : () {
                    // Block tap if no customer selected
                    if (state.selectedCustomer == null) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: const Text("Please select a customer first"),
                        behavior: SnackBarBehavior.floating,
                      ));
                      return;
                    }

                    // Pass the SELECTED CUSTOMER'S vehicles only
                    _showVehicleSearchSheet(
                        context,
                        state.selectedCustomer!.vehicles,
                        controller,
                        state.selectedCustomer!);
                  },
            child: _glassInputContainer(
              context,
              hasError: vehicleError,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      _getVehicleDisplayText(state.selectedVehicle),
                      style: state.selectedVehicle != null
                          ? valueStyle
                          : placeholderStyle,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Icon(Icons.keyboard_arrow_down,
                      color: GlassColors.textSubtle),
                ],
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 4, left: 4),
            child: vehicleError
                ? Text(titleErrorText, style: errorTextStyle)
                : SizedBox(),
          ),
        ],
      ),
    );
  }

  // --- HELPER: FORMAT DISPLAY TEXT ---
  String _getVehicleDisplayText(Vehicle? vehicle) {
    if (vehicle == null) return "Select Vehicle";

    // Logic: "Honda City" OR "Honda City - MH 12 AB 1234"
    if (vehicle.number != null && vehicle.number!.isNotEmpty) {
      return "${vehicle.name}  •  ${vehicle.number}";
    }
    return vehicle.name;
  }

  // --- HELPER: SHOW CUSTOMER SHEET ---
  void _showCustomerSearchSheet(BuildContext context, List<Customer> customers,
      AddJobController controller) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => CustomerSearchSheet(
        customers: customers,
        onSelect: (customer) {
          controller.selectCustomer(customer);
          // Important: Clear vehicle when customer changes (prevents mismatch)
          controller.selectVehicle(null);
        },
        onCreateNew: (nameTyped) async {
          final newCustomer = await showDialog<Customer>(
            context: context,
            builder: (context) => AddCustomerDialog(initialName: nameTyped),
          );
          if (newCustomer != null) {
            controller.selectCustomer(newCustomer);
            controller.selectVehicle(null);
          }
        },
      ),
    );
  }

  // --- HELPER: SHOW VEHICLE SHEET ---
  void _showVehicleSearchSheet(BuildContext context, List<Vehicle> vehicles,
      AddJobController controller, Customer currentCustomer) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => VehicleSearchSheet(
        vehicles: vehicles,
        onSelect: (vehicle) => controller.selectVehicle(vehicle),
        onCreateNew: (initialInput) async {
          // Open Add Vehicle Dialog
          final newVehicle = await showDialog<Vehicle>(
            context: context,
            builder: (context) => AddVehicleDialog(
                customer: currentCustomer, initialValue: initialInput),
          );

          if (newVehicle != null) {
            // Note: The controller/provider needs to refresh the customer list
            // so the new vehicle appears in future searches.
            // Since we updated the DB in the dialog, selecting it here visually is enough for now.
            controller.selectVehicle(newVehicle);
          }
        },
      ),
    );
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
