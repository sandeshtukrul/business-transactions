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
    final bool showFab = tabController.index == 0;

    return showFab ? MyFab(onPressed: onPressed) : const SizedBox.shrink();
  }
}
