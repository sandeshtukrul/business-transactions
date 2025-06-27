import 'package:business_transactions/features/transaction_form/widgets/form_section_header.dart';
import 'package:flutter/material.dart';

class FormSection extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<Widget> children;
  final bool showDivider;

  const FormSection({
    super.key,
    required this.title,
    required this.icon,
    required this.children,
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FormSectionHeader(icon: icon, title: title),
        const SizedBox(height: 20),
        ...children.map((child) => Padding(
              padding: const EdgeInsets.only(bottom: 18),
              child: child,
            )),
        if (showDivider)
          Divider(
            color: colorScheme.outline.withValues(alpha: 0.5),
            thickness: 1,
            height: 20,
          )
      ],
    );
  }
}
