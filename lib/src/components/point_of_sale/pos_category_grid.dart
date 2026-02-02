import 'package:artists_alley_dashboard/src/components/components.dart';
import 'package:artists_alley_dashboard/src/data/data.dart';
import 'package:artists_alley_dashboard/src/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PosCategoryGrid extends StatelessWidget {
  const PosCategoryGrid({
    super.key,
    required this.presenter,
    required this.controller,
  });

  final PointOfSaleViewPresenter presenter;
  final PointOfSaleViewController controller;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = constraints.maxWidth >= 900
            ? 2
            : constraints.maxWidth >= 640
            ? 2
            : 1;
        return Obx(() {
          final selected = presenter.selectedCategoryId;
          final hasSelection = selected != null && selected.isNotEmpty;
          final categories = presenter.categories;
          final products = presenter.products;
          final hasCategories = categories.isNotEmpty;
          final hasProducts = products.isNotEmpty;
          final itemCount = hasSelection ? products.length : categories.length;
          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.3,
            ),
            itemCount: itemCount,
            itemBuilder: (context, index) {
              final category = hasCategories
                  ? categories[index]
                  : PosCategory(
                      id: 'empty',
                      title: presenter.selectedCategoryId == ""
                          ? 'No categories yet'
                          : 'No products yet',
                      description: presenter.selectedCategoryId == ""
                          ? 'Add categories to start selling.'
                          : 'Add products to start selling.',
                      icon: Icons.add_circle_outline,
                    );
              final product = hasProducts && hasSelection
                  ? products[index]
                  : PosProduct(
                      id: 'empty',
                      categoryId: category.id,
                      title: 'No products yet',
                      description: 'Add products to start selling.',
                      icon: Icons.add_circle_outline,
                      price: 0.0,
                      stock: 0,
                    );
              if (hasSelection) {
                return PosProductCard(
                  onAddToCart: (product) => controller.onAddToCart(product),
                  product: product,
                  onTap: hasProducts
                      ? () => controller.onProductTap(product.id)
                      : () => controller.onAddProductTap(),
                );
              }
              return PosCategoryCard(
                category: category,
                onTap: hasCategories
                    ? () => hasSelection
                          ? controller.onProductTap(category.id)
                          : controller.onCategoryTap(category.id)
                    : () => hasSelection
                          ? controller.onAddProductTap()
                          : controller.onAddCategoryTap(),
              );
            },
          );
        });
      },
    );
  }
}
