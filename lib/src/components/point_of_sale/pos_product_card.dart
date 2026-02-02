import 'package:artists_alley_dashboard/src/components/components.dart';
import 'package:artists_alley_dashboard/src/config/constants/constants.dart';
import 'package:artists_alley_dashboard/src/data/data.dart';
import 'package:artists_alley_dashboard/src/presentation/presentation.dart';
import 'package:artists_alley_dashboard/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PosProductCard extends StatelessWidget {
  const PosProductCard({
    super.key,
    required this.product,
    required this.onTap,
    required this.onAddToCart,
  });

  final PosProduct product;
  final VoidCallback onTap;
  final void Function(PosProduct) onAddToCart;

  @override
  Widget build(BuildContext context) {
    final presenter = Get.find<PointOfSaleViewPresenter>();
    final titleStyle = Theme.of(context).textTheme.bodyLarge?.copyWith(
      fontWeight: FontWeight.w600,
      color: CustomColors.primaryText,
    );
    final subtitleStyle = Theme.of(
      context,
    ).textTheme.bodySmall?.copyWith(color: CustomColors.mutedText);
    final priceStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(
      fontWeight: FontWeight.w600,
      color: CustomColors.primary,
    );
    return PosCard(
      padding: EdgeInsets.zero,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: CustomColors.primary.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(product.icon, color: CustomColors.primary),
                      ),
                      const SizedBox(width: 12),
                      Expanded(child: Text(product.title, style: titleStyle)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        CurrencyHelper.formatCurrency(product.price),
                        style: priceStyle,
                      ),
                      const Spacer(),
                      QtyButton(
                        icon: Icons.remove,
                        onPressed: () {
                          final currentQuantity =
                              presenter.selectedQuantities[product.id] ??
                              product.quantity;
                          final nextQuantity = (currentQuantity - 1).clamp(
                            1,
                            99,
                          );
                          product.quantity = nextQuantity;
                          presenter.selectedQuantities[product.id] =
                              nextQuantity;
                        },
                      ),
                      const SizedBox(width: 8),
                      Obx(() {
                        final quantity =
                            presenter.selectedQuantities[product.id] ??
                            product.quantity;
                        return Text(quantity.toString(), style: titleStyle);
                      }),
                      const SizedBox(width: 8),
                      QtyButton(
                        icon: Icons.add,
                        onPressed: () {
                          final currentQuantity =
                              presenter.selectedQuantities[product.id] ??
                              product.quantity;
                          final nextQuantity = (currentQuantity + 1).clamp(
                            1,
                            99,
                          );
                          product.quantity = nextQuantity;
                          presenter.selectedQuantities[product.id] =
                              nextQuantity;
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(product.description, style: subtitleStyle),
                  const SizedBox(height: 12),
                ],
              ),

              SizedBox(
                width: double.infinity,
                height: 44,
                child: ElevatedButton.icon(
                  onPressed: () => onAddToCart(product),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: CustomColors.primary,
                    foregroundColor: CustomColors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  icon: const Icon(Icons.add_shopping_cart_outlined, size: 20),
                  label: const Text('Add to cart'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
