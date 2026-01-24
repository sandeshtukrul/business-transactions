import 'package:business_transactions/config/glass_theme.dart';
import 'package:business_transactions/features/jobs/shared/glass_sheet.dart';
import 'package:business_transactions/models/customer.dart';
import 'package:flutter/material.dart';

class CustomerSearchSheet extends StatefulWidget {
  final List<Customer> customers;
  final Function(Customer) onSelect;
  final Function(String) onCreateNew;

  const CustomerSearchSheet({super.key, required this.customers, required this.onSelect, required this.onCreateNew});

  @override
  State<CustomerSearchSheet> createState() => _CustomerSearchSheetState();
}

class _CustomerSearchSheetState extends State<CustomerSearchSheet> {
  final _searchController = TextEditingController();
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final borderColor = theme.brightness == Brightness.dark ? GlassColors.glassBorderDark : GlassColors.glassBorderLight;

    final filtered = widget.customers.where((c) => c.name.toLowerCase().contains(_query)).toList();

    return DraggableScrollableSheet(
      initialChildSize: 0.85,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      expand: false,
      builder: (context, scrollController) {
        return GlassSheetWrapper(
          scrollController: scrollController,
          children: [
            // REUSED SEARCH BAR
            GlassSheetSearchBar(
              controller: _searchController,
              hintText: "Search customer...",
              onChanged: (val) => setState(() => _query = val.toLowerCase()),
              onClear: () { _searchController.clear(); setState(() => _query = ''); },
            ),
            
            // LIST
            Expanded(
              child: ListView.separated(
                controller: scrollController,
                itemCount: filtered.length + 1,
                separatorBuilder: (_, __) => Divider(height: 1, indent: 80, endIndent: 20, color: borderColor),
                itemBuilder: (context, index) {
                  // REUSED CREATE TILE
                  if (index == 0) {
                    return GlassCreateTile(
                      label: _query.isEmpty ? "Create New Customer" : "Create '$_query'",
                      onTap: () { Navigator.pop(context); widget.onCreateNew(_searchController.text); },
                    );
                  }
                  // REUSED ITEM TILE
                  final customer = filtered[index - 1];
                  return GlassItemTile(
                    leadingIcon: CircleAvatar(
                      radius: 24,
                      backgroundColor: theme.colorScheme.surfaceContainerHighest,
                      child: Text(customer.name.isNotEmpty ? customer.name[0].toUpperCase() : "?", style: TextStyle(fontWeight: FontWeight.bold, color: colorScheme.onSurfaceVariant)),
                    ),
                    title: customer.name,
                    subtitle: "${customer.vehicles.length} Vehicles",
                    onTap: () { widget.onSelect(customer); Navigator.pop(context); },
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