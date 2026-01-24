import 'package:business_transactions/config/glass_theme.dart';
import 'package:business_transactions/features/jobs/shared/glass_sheet.dart';
import 'package:business_transactions/models/vehicle.dart';
import 'package:flutter/material.dart';

class VehicleSearchSheet extends StatefulWidget {
  final List<Vehicle> vehicles;
  final Function(Vehicle) onSelect;
  final Function(String) onCreateNew;

  const VehicleSearchSheet({super.key, required this.vehicles, required this.onSelect, required this.onCreateNew});

  @override
  State<VehicleSearchSheet> createState() => _VehicleSearchSheetState();
}

class _VehicleSearchSheetState extends State<VehicleSearchSheet> {
  final _searchController = TextEditingController();
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
     final borderColor = theme.brightness == Brightness.dark ? GlassColors.glassBorderDark : GlassColors.glassBorderLight;

    final filtered = widget.vehicles.where((v) {
      return (v.number?.toLowerCase() ?? "").contains(_query) || v.name.toLowerCase().contains(_query);
    }).toList();

    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      minChildSize: 0.4,
      maxChildSize: 0.9,
      expand: false,
      builder: (context, scrollController) {
        return GlassSheetWrapper(
          scrollController: scrollController,
          children: [
            GlassSheetSearchBar(
              controller: _searchController,
              hintText: "Search number or model...",
              textCapitalization: true, // Caps for vehicle
              onChanged: (val) => setState(() => _query = val.toLowerCase()),
              onClear: () { _searchController.clear(); setState(() => _query = ''); },
            ),
            Expanded(
              child: ListView.separated(
                controller: scrollController,
                itemCount: filtered.length + 1,
                separatorBuilder: (_, __) => Divider(height: 1, indent: 80, endIndent: 20, color: borderColor),
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return GlassCreateTile(
                      label: _query.isEmpty ? "Add New Vehicle" : "Add '$_query'",
                      onTap: () { Navigator.pop(context); widget.onCreateNew(_searchController.text); },
                    );
                  }
                  final vehicle = filtered[index - 1];
                  final hasNumber = vehicle.number != null && vehicle.number!.isNotEmpty;
                  return GlassItemTile(
                    leadingIcon: CircleAvatar(
                      radius: 24,
                      backgroundColor: colorScheme.surfaceContainerHighest,
                      child: Icon(Icons.directions_car, color: colorScheme.onSurfaceVariant),
                    ),
                    title: vehicle.name,
                    subtitle: hasNumber ? vehicle.number! : "No Number Plate",
                    isSubtitleItalic: !hasNumber,
                    onTap: () { widget.onSelect(vehicle); Navigator.pop(context); },
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}