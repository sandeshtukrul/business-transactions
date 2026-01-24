import 'package:business_transactions/config/constants/string_const.dart';
import 'package:flutter/material.dart';

class HomeFab extends StatelessWidget {
  final VoidCallback onPressed;

  const HomeFab({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      label: const Text(newJob),
      onPressed: onPressed,
      icon: const Icon(Icons.add_task),
    );
  }
}
