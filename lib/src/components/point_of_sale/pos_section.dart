import 'package:flutter/material.dart';

class PosSection extends StatelessWidget {
  const PosSection({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [const SizedBox(height: 12), child],
    );
  }
}
