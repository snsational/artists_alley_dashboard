import 'package:artists_alley_dashboard/src/components/components.dart';
import 'package:artists_alley_dashboard/src/presentation/presentation.dart';
import 'package:artists_alley_dashboard/src/utils/currency/currency_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardMainColumn extends StatelessWidget {
  const DashboardMainColumn({
    super.key,
    required this.controller,
    required this.presenter,
  });

  final HomeViewController controller;
  final HomeViewPresenter presenter;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        DashboardHeader(),
        const SizedBox(height: 24),
        DashboardSection(
          title: 'Overview',
          child: Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              Obx(() {
                final totalSales = presenter.totalSales;
                return DashboardStatCard(
                  title: 'Total Sales',
                  value: '\$${CurrencyHelper.formatCurrency(totalSales)}',
                  helper: '+??% vs last event',
                  icon: Icons.payments_outlined,
                );
              }),
              Obx(() {
                final totalOrders = presenter.totalOrders;
                final average = totalOrders == 0
                    ? 0.0
                    : presenter.totalSales / totalOrders;
                return DashboardStatCard(
                  title: 'Orders',
                  value: '$totalOrders',
                  helper: 'Avg \$${CurrencyHelper.formatCurrency(average)}',
                  icon: Icons.receipt_long_outlined,
                );
              }),
              DashboardStatCard(
                title: '??',
                value: '\$??',
                helper: '??',
                icon: Icons.account_balance_wallet_outlined,
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        DashboardSection(
          title: 'Top Performing Items',
          child: DashboardListCard(
            items: const [
              DashboardListItem(
                title: 'Saiki K',
                subtitle: 'Illustration + Prints',
                trailing: '\$14,980',
                icon: Icons.auto_awesome_outlined,
              ),
              DashboardListItem(
                title: 'Maltinha da Pesada',
                subtitle: 'Stickers + Originals',
                trailing: '\$12,430',
                icon: Icons.brush_outlined,
              ),
              DashboardListItem(
                title: 'Maltinha da Pesada',
                subtitle: 'Merch + Apparel',
                trailing: '\$9,805',
                icon: Icons.shopping_bag_outlined,
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        DashboardSection(
          title: 'Sales Momentum',
          child: DashboardListCard(
            items: const [
              DashboardListItem(
                title: 'Peak hour',
                subtitle: 'Saturday 2:00 PM',
                trailing: '\$6,120',
                icon: Icons.insights_outlined,
              ),
              DashboardListItem(
                title: 'Best category',
                subtitle: 'Prints + Posters',
                trailing: '\$28,540',
                icon: Icons.local_fire_department_outlined,
              ),
              DashboardListItem(
                title: 'Top payment method',
                subtitle: 'Tap to Pay',
                trailing: '62%',
                icon: Icons.tap_and_play_outlined,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
