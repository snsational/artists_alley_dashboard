import 'package:artists_alley_dashboard/src/config/constants/constants.dart';
import 'package:flutter/material.dart';

class DashboardHeader extends StatelessWidget {
  const DashboardHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final headline = Theme.of(context).textTheme.headlineMedium?.copyWith(
      fontWeight: FontWeight.w700,
      color: CustomColors.primaryText,
    );
    final subtitle = Theme.of(
      context,
    ).textTheme.bodyMedium?.copyWith(color: CustomColors.mutedText);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Artist Alley Dashboard', style: headline),
              const SizedBox(height: 6),
              Text(
                'Track revenue, inventory levels, and performance by item.',
                style: subtitle,
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        ElevatedButton.icon(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: CustomColors.primary,
            foregroundColor: CustomColors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          icon: const Icon(Icons.add),
          label: const Text('Create Payout'),
        ),
      ],
    );
  }
}
