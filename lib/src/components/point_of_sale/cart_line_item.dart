import 'package:artists_alley_dashboard/src/config/constants/constants.dart';
import 'package:artists_alley_dashboard/src/data/data.dart';
import 'package:artists_alley_dashboard/src/presentation/presentation.dart';
import 'package:artists_alley_dashboard/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartLineItem extends StatelessWidget {
  const CartLineItem({super.key, required this.item});

  final PosProduct item;

  @override
  Widget build(BuildContext context) {
    final presenter = Get.find<PointOfSaleViewPresenter>();
    final titleStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(
      fontWeight: FontWeight.w600,
      color: CustomColors.primaryText,
    );
    final subtitleStyle = Theme.of(
      context,
    ).textTheme.bodySmall?.copyWith(color: CustomColors.mutedText);
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(item.title, style: titleStyle),
              const SizedBox(height: 4),
              Text(
                '${item.quantity} x ${CurrencyHelper.formatCurrency(item.price)}',
                style: subtitleStyle,
              ),
            ],
          ),
        ),
        Text(
          CurrencyHelper.formatCurrency(item.price * item.quantity),
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: CustomColors.primary,
          ),
        ),
        const SizedBox(width: 12),
        IconButton(
          tooltip: 'Remove item',
          onPressed: () {
            presenter.cartItems.remove(item);
            final updatedTotal =
                presenter.cartTotal - (item.price * item.quantity);
            presenter.cartTotal = updatedTotal < 0 ? 0 : updatedTotal;
            presenter.update();
          },
          icon: const Icon(Icons.close, size: 18),
          style: IconButton.styleFrom(
            foregroundColor: Colors.redAccent,
            backgroundColor: CustomColors.inputFill,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    );
  }
}
