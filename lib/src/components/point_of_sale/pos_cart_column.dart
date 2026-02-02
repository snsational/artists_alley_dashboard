import 'package:artists_alley_dashboard/src/components/components.dart';
import 'package:artists_alley_dashboard/src/config/constants/constants.dart';
import 'package:artists_alley_dashboard/src/presentation/presentation.dart';
import 'package:artists_alley_dashboard/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PosCartColumn extends StatelessWidget {
  const PosCartColumn({
    super.key,
    required this.presenter,
    required this.controller,
  });

  final PointOfSaleViewPresenter presenter;
  final PointOfSaleViewController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final total = presenter.cartTotal;
      final cartItems = presenter.cartItems;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          PosSection(
            child: PosCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (cartItems.isEmpty)
                    Text(
                      'No items yet. Add products to build the cart.',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: CustomColors.mutedText,
                      ),
                    )
                  else
                    Column(
                      children: [
                        for (var i = 0; i < cartItems.length; i++) ...[
                          if (i > 0) const Divider(height: 20),
                          CartLineItem(item: cartItems[i]),
                        ],
                      ],
                    ),
                  const SizedBox(height: 16),
                  const Divider(height: 20),
                  Row(
                    children: [
                      Text(
                        'Total',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: CustomColors.primaryText,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        CurrencyHelper.formatCurrency(total),
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: CustomColors.primary,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 48,
                    child: ElevatedButton.icon(
                      onPressed: cartItems.isEmpty
                          ? null
                          : controller.onCheckoutTap,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: CustomColors.primary,
                        foregroundColor: CustomColors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      icon: const Icon(Icons.lock_outlined, size: 20),
                      label: const Text('Checkout'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    });
  }
}
