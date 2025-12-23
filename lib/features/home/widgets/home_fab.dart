import 'package:flutter/material.dart';

class MyFab extends StatelessWidget {
  final VoidCallback onPressed;

  const MyFab({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      child: Icon(Icons.add),
    );
  }
}

/// Controls the visibility of the FAB based on the current Tab.
/// Extends [AnimatedWidget] to listen to the TabController's animation changes
class FabManager extends AnimatedWidget {
  final TabController tabController;
  final VoidCallback onPressed;

  const FabManager({
    super.key,
    required this.tabController,
    required this.onPressed,
  }) : super(listenable: tabController);

  @override
  Widget build(BuildContext context) {
    // Only show FAB on the "Customers" tab (Index 0)
    final bool showFab = tabController.index == 0;

    return showFab ? MyFab(onPressed: onPressed) : const SizedBox.shrink();
  }
}
