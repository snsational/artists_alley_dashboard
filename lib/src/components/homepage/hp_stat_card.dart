import 'package:artists_alley_dashboard/src/components/components.dart';
import 'package:artists_alley_dashboard/src/config/constants/constants.dart';
import 'package:flutter/material.dart';

class DashboardStatCard extends StatelessWidget {
  const DashboardStatCard({
    super.key,
    required this.title,
    required this.value,
    required this.helper,
    required this.icon,
  });

  final String title;
  final String value;
  final String helper;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(
      context,
    ).textTheme.bodyMedium?.copyWith(color: CustomColors.mutedText);
    final valueStyle = Theme.of(context).textTheme.headlineSmall?.copyWith(
      fontWeight: FontWeight.w700,
      color: CustomColors.primaryText,
    );
    final helperStyle = Theme.of(context).textTheme.bodySmall?.copyWith(
      color: CustomColors.primary,
      fontWeight: FontWeight.w600,
    );
    return SizedBox(
      width: 280,
      child: DashboardCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: CustomColors.primary.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(icon, color: CustomColors.primary),
            ),
            const SizedBox(height: 16),
            Text(title, style: titleStyle),
            const SizedBox(height: 6),
            Text(value, style: valueStyle),
            const SizedBox(height: 8),
            Text(helper, style: helperStyle),
          ],
        ),
      ),
    );
  }
}
