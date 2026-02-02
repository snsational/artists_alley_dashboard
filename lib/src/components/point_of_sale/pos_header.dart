import 'package:artists_alley_dashboard/src/config/constants/constants.dart';
import 'package:artists_alley_dashboard/src/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PosHeader extends StatelessWidget {
  const PosHeader({
    super.key,
    required this.presenter,
    required this.controller,
  });

  final PointOfSaleViewPresenter presenter;
  final PointOfSaleViewController controller;

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
              Text('Point of Sale', style: headline),
              const SizedBox(height: 6),
              Text(
                'Select a category, set quantities, and add items to the cart.',
                style: subtitle,
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        Obx(
          () => ElevatedButton.icon(
            onPressed: presenter.selectedCategoryId == ""
                ? controller.onAddCategoryTap
                : controller.onAddProductTap,
            style: ElevatedButton.styleFrom(
              backgroundColor: CustomColors.primary,
              foregroundColor: CustomColors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            icon: const Icon(Icons.category),
            label: presenter.selectedCategoryId == ""
                ? const Text('Add Category')
                : const Text('Add Product'),
          ),
        ),
      ],
    );
  }
}
