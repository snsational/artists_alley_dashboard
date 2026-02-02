import 'package:artists_alley_dashboard/src/config/constants/constants.dart';
import 'package:flutter/material.dart';

class PosCard extends StatelessWidget {
  const PosCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(20),
  });

  final Widget child;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 8,
      borderRadius: BorderRadius.circular(20),
      color: CustomColors.white,
      child: Padding(padding: padding, child: child),
    );
  }
}
