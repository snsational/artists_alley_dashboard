import 'package:artists_alley_dashboard/src/config/constants/constants.dart';
import 'package:flutter/material.dart';

class DashboardCard extends StatelessWidget {
  const DashboardCard({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 8,
      borderRadius: BorderRadius.circular(20),
      color: CustomColors.white,
      child: Padding(padding: const EdgeInsets.all(20), child: child),
    );
  }
}
