import 'package:artists_alley_dashboard/src/config/constants/constants.dart';
import 'package:artists_alley_dashboard/src/presentation/presentation.dart';
import 'package:flutter/material.dart';

class HomeView extends CustomGetView<HomeViewController, HomeViewPresenter> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWideLayout = constraints.maxWidth >= 1100;
          final horizontalPadding = isWideLayout ? 48.0 : 24.0;
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      CustomColors.loginGradientStart,
                      CustomColors.loginGradientEnd,
                    ],
                  ),
                ),
                child: SafeArea(
                  minimum: const EdgeInsets.only(bottom: 24),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: horizontalPadding,
                      vertical: 32,
                    ),
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 1200),
                        child: isWideLayout
                            ? Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(child: _DashboardMainColumn()),
                                  const SizedBox(width: 32),
                                  const SizedBox(
                                    width: 320,
                                    child: _DashboardSideColumn(),
                                  ),
                                ],
                              )
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: const [
                                  _DashboardMainColumn(),
                                  SizedBox(height: 24),
                                  _DashboardSideColumn(),
                                ],
                              ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _DashboardMainColumn extends StatelessWidget {
  const _DashboardMainColumn();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _DashboardHeader(),
        const SizedBox(height: 24),
        _DashboardSection(
          title: 'Overview',
          child: Wrap(
            spacing: 16,
            runSpacing: 16,
            children: const [
              _DashboardStatCard(
                title: 'Total Sales',
                value: '\$84,230',
                helper: '+18% vs last event',
                icon: Icons.payments_outlined,
              ),
              _DashboardStatCard(
                title: 'Orders',
                value: '1,482',
                helper: 'Avg \$56.8',
                icon: Icons.receipt_long_outlined,
              ),
              _DashboardStatCard(
                title: 'Payouts Due',
                value: '\$12,910',
                helper: 'Next batch Fri',
                icon: Icons.account_balance_wallet_outlined,
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        _DashboardSection(
          title: 'Top Performing Items',
          child: _DashboardListCard(
            items: const [
              _DashboardListItem(
                title: 'Saiki K',
                subtitle: 'Illustration + Prints',
                trailing: '\$14,980',
                icon: Icons.auto_awesome_outlined,
              ),
              _DashboardListItem(
                title: 'Maltinha da Pesada',
                subtitle: 'Stickers + Originals',
                trailing: '\$12,430',
                icon: Icons.brush_outlined,
              ),
              _DashboardListItem(
                title: 'Maltinha da Pesada',
                subtitle: 'Merch + Apparel',
                trailing: '\$9,805',
                icon: Icons.shopping_bag_outlined,
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        _DashboardSection(
          title: 'Sales Momentum',
          child: _DashboardListCard(
            items: const [
              _DashboardListItem(
                title: 'Peak hour',
                subtitle: 'Saturday 2:00 PM',
                trailing: '\$6,120',
                icon: Icons.insights_outlined,
              ),
              _DashboardListItem(
                title: 'Best category',
                subtitle: 'Prints + Posters',
                trailing: '\$28,540',
                icon: Icons.local_fire_department_outlined,
              ),
              _DashboardListItem(
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

class _DashboardSideColumn extends StatelessWidget {
  const _DashboardSideColumn();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _DashboardSection(
          title: 'Sales Tools',
          child: _DashboardCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _DashboardActionButton(
                  label: 'Open Point of Sale',
                  icon: Icons.point_of_sale_outlined,
                ),
                const SizedBox(height: 12),
                _DashboardActionButton(
                  label: 'Schedule Payouts',
                  icon: Icons.calendar_today_outlined,
                ),
                const SizedBox(height: 12),
                _DashboardActionButton(
                  label: 'Send Artist Update',
                  icon: Icons.markunread_outlined,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
        _DashboardSection(
          title: 'Sales Targets',
          child: _DashboardListCard(
            items: const [
              _DashboardListItem(
                title: 'Floor average',
                subtitle: 'Goal \$2,500 per booth',
                trailing: '82%',
                icon: Icons.flag_outlined,
              ),
              _DashboardListItem(
                title: 'VIP preview night',
                subtitle: 'Upsell bundles',
                trailing: '\$8,900',
                icon: Icons.star_outline,
              ),
              _DashboardListItem(
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

class _DashboardHeader extends StatelessWidget {
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

class _DashboardSection extends StatelessWidget {
  const _DashboardSection({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleMedium?.copyWith(
      fontWeight: FontWeight.w600,
      color: CustomColors.primaryText,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(title, style: titleStyle),
        const SizedBox(height: 12),
        child,
      ],
    );
  }
}

class _DashboardCard extends StatelessWidget {
  const _DashboardCard({required this.child});

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

class _DashboardStatCard extends StatelessWidget {
  const _DashboardStatCard({
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
      child: _DashboardCard(
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

class _DashboardListCard extends StatelessWidget {
  const _DashboardListCard({required this.items});

  final List<_DashboardListItem> items;

  @override
  Widget build(BuildContext context) {
    return _DashboardCard(
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

class _DashboardListItem extends StatelessWidget {
  const _DashboardListItem({
    required this.title,
    required this.subtitle,
    required this.trailing,
    required this.icon,
  });

  final String title;
  final String subtitle;
  final String trailing;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.bodyLarge?.copyWith(
      fontWeight: FontWeight.w600,
      color: CustomColors.primaryText,
    );
    final subtitleStyle = Theme.of(
      context,
    ).textTheme.bodySmall?.copyWith(color: CustomColors.mutedText);
    final trailingStyle = Theme.of(context).textTheme.bodySmall?.copyWith(
      color: CustomColors.primary,
      fontWeight: FontWeight.w600,
    );
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: CustomColors.primary.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: CustomColors.primary, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: titleStyle),
              const SizedBox(height: 4),
              Text(subtitle, style: subtitleStyle),
            ],
          ),
        ),
        const SizedBox(width: 12),
        Text(trailing, style: trailingStyle),
      ],
    );
  }
}

class _DashboardActionButton extends StatelessWidget {
  const _DashboardActionButton({required this.label, required this.icon});

  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: () {},
      style: OutlinedButton.styleFrom(
        foregroundColor: CustomColors.mutedText,
        backgroundColor: CustomColors.white,
        side: const BorderSide(color: CustomColors.inputFill),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      icon: Icon(icon, size: 20),
      label: Text(label),
    );
  }
}
