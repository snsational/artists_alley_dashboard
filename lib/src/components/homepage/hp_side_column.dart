import 'package:artists_alley_dashboard/src/components/components.dart';
import 'package:flutter/material.dart';

class DashboardSideColumn extends StatelessWidget {
  const DashboardSideColumn({super.key, this.onPointOfSaleTap});

  final VoidCallback? onPointOfSaleTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        DashboardSection(
          title: 'Sales Tools',
          child: DashboardCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                DashboardActionButton(
                  label: 'Open Point of Sale',
                  icon: Icons.point_of_sale_outlined,
                  onPressed: onPointOfSaleTap,
                ),
                const SizedBox(height: 12),
                DashboardActionButton(
                  label: 'Schedule Payouts',
                  icon: Icons.calendar_today_outlined,
                ),
                const SizedBox(height: 12),
                DashboardActionButton(
                  label: 'Send Artist Update',
                  icon: Icons.markunread_outlined,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
        DashboardSection(
          title: 'Sales Targets',
          child: DashboardListCard(
            items: const [
              DashboardListItem(
                title: 'Floor average',
                subtitle: 'Goal \$2,500 per booth',
                trailing: '82%',
                icon: Icons.flag_outlined,
              ),
              DashboardListItem(
                title: 'VIP preview night',
                subtitle: 'Upsell bundles',
                trailing: '\$8,900',
                icon: Icons.star_outline,
              ),
              DashboardListItem(
                title: 'Sunday closeout',
                subtitle: 'Clear inventory',
                trailing: '\$6,200',
                icon: Icons.sell_outlined,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
