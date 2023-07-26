import 'package:flutter/material.dart';

class DashboardCard extends StatelessWidget {
  const DashboardCard({this.child, super.key});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ConstrainedBox(
          constraints: const BoxConstraints.expand(height: 600),
          child: child ?? const Placeholder(),
        ),
      ),
    );
  }
}
