import 'package:artists_alley_dashboard/src/components/components.dart';
import 'package:flutter/material.dart';

class DashboardListCard extends StatelessWidget {
  const DashboardListCard({super.key, required this.items});

  final List<DashboardListItem> items;

  @override
  Widget build(BuildContext context) {
    return DashboardCard(
      child: Column(
        children: [
          for (var i = 0; i < items.length; i++) ...[
            if (i > 0) const Divider(height: 24),
            items[i],
          ],
        ],
      ),
    );
  }
}
