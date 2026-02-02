import 'dart:developer';

import 'package:artists_alley_dashboard/src/data/data.dart';
import 'package:artists_alley_dashboard/src/config/constants/constants.dart';
import 'package:artists_alley_dashboard/src/presentation/presentation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PointOfSaleViewControl implements PointOfSaleViewController {
  PointOfSaleViewControl(this.presenter);

  final PointOfSaleViewPresenter presenter;

  @override
  Future<void> onProductTap(String categoryId) async {
    log("Category tapped: $categoryId");
  }

  @override
  Future<void> onAddProductTap() async {
    log("Add product tapped");
    final selectedCategoryId = presenter.selectedCategoryId;
    if (selectedCategoryId == null || selectedCategoryId.isEmpty) {
      log("No category selected. Cannot add product.");
      return;
    }

    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    final priceController = TextEditingController();
    final stockController = TextEditingController();
    String? titleErrorText;
    String? priceErrorText;
    String? stockErrorText;
    IconData selectedIcon = Icons.inventory_2_outlined;
    const availableIcons = [
      Icons.inventory_2_outlined,
      Icons.local_mall_outlined,
      Icons.sell_outlined,
      Icons.shopping_bag_outlined,
      Icons.checkroom_outlined,
      Icons.palette_outlined,
      Icons.photo_library_outlined,
      Icons.auto_awesome_outlined,
      Icons.brush_outlined,
      Icons.stars_outlined,
      Icons.emoji_emotions_outlined,
      Icons.layers_outlined,
      Icons.edit_outlined,
      Icons.category_outlined,
    ];

    String buildProductId(String title) {
      final base = title
          .trim()
          .toLowerCase()
          .replaceAll(RegExp(r'[^a-z0-9]+'), '-')
          .replaceAll(RegExp(r'^-+|-+$'), '');
      final fallback = base.isEmpty ? 'product' : base;
      final existingIds = presenter.products.map((p) => p.id).toSet();
      final scopedBase = '$selectedCategoryId-$fallback';
      var candidate = scopedBase;
      var suffix = 2;
      while (existingIds.contains(candidate)) {
        candidate = '$scopedBase-$suffix';
        suffix++;
      }
      return candidate;
    }

    PosCategory? selectedCategory;
    for (final category in presenter.categories) {
      if (category.id == selectedCategoryId) {
        selectedCategory = category;
        break;
      }
    }
    final categoryLabel = selectedCategory?.title ?? 'Selected category';

    await Get.dialog(
      StatefulBuilder(
        builder: (context, setState) {
          final theme = Theme.of(context);
          return AlertDialog(
            backgroundColor: CustomColors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            titlePadding: const EdgeInsets.fromLTRB(24, 24, 24, 8),
            contentPadding: const EdgeInsets.fromLTRB(24, 0, 24, 8),
            actionsPadding: const EdgeInsets.fromLTRB(24, 8, 24, 20),
            title: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: CustomColors.inputFill,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.inventory_2_outlined,
                    color: CustomColors.primary,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Add product',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: CustomColors.primaryText,
                    ),
                  ),
                ),
              ],
            ),
            content: SizedBox(
              width: 360,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Create a new product for $categoryLabel.',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: CustomColors.mutedText,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: titleController,
                    textInputAction: TextInputAction.next,
                    autofocus: true,
                    decoration: InputDecoration(
                      labelText: 'Title',
                      errorText: titleErrorText,
                      prefixIcon: const Icon(Icons.title),
                      filled: true,
                      fillColor: CustomColors.inputFill,
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: descriptionController,
                    keyboardType: TextInputType.multiline,
                    minLines: 3,
                    maxLines: 6,
                    decoration: const InputDecoration(
                      labelText: 'Description',
                      helperText: 'Optional',
                      prefixIcon: Icon(Icons.notes_outlined),
                      filled: true,
                      fillColor: CustomColors.inputFill,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: priceController,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    decoration: InputDecoration(
                      labelText: 'Price',
                      errorText: priceErrorText,
                      prefixIcon: const Icon(Icons.attach_money),
                      filled: true,
                      fillColor: CustomColors.inputFill,
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: stockController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Stock',
                      errorText: stockErrorText,
                      prefixIcon: const Icon(Icons.inventory_2_outlined),
                      filled: true,
                      fillColor: CustomColors.inputFill,
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Icon',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: CustomColors.primaryText,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      for (final icon in availableIcons)
                        InkWell(
                          borderRadius: BorderRadius.circular(12),
                          onTap: () {
                            setState(() {
                              selectedIcon = icon;
                            });
                          },
                          child: Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              color: CustomColors.inputFill,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: icon == selectedIcon
                                    ? CustomColors.primary
                                    : Colors.transparent,
                                width: 1.5,
                              ),
                            ),
                            child: Icon(
                              icon,
                              color: icon == selectedIcon
                                  ? CustomColors.primary
                                  : CustomColors.mutedText,
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
            actions: [
              SizedBox(
                height: 44,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: CustomColors.mutedText,
                    side: const BorderSide(color: CustomColors.inputFill),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () => Get.back<void>(),
                  child: const Text('Cancel'),
                ),
              ),
              const SizedBox(width: 8),
              SizedBox(
                height: 44,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: CustomColors.primary,
                    foregroundColor: CustomColors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () async {
                    final title = titleController.text.trim();
                    final priceText = priceController.text.trim();
                    final stockText = stockController.text.trim();
                    setState(() {
                      titleErrorText = null;
                      priceErrorText = null;
                      stockErrorText = null;
                    });

                    if (title.isEmpty) {
                      setState(() {
                        titleErrorText = 'Title is required';
                      });
                      return;
                    }

                    final price = double.tryParse(priceText);
                    if (price == null || price < 0) {
                      setState(() {
                        priceErrorText = 'Enter a valid price';
                      });
                      return;
                    }

                    final stock = int.tryParse(stockText);
                    if (stock == null || stock < 0) {
                      setState(() {
                        stockErrorText = 'Enter a valid stock';
                      });
                      return;
                    }

                    final description = descriptionController.text.trim();
                    final product = PosProduct(
                      id: buildProductId(title),
                      categoryId: selectedCategoryId,
                      title: title,
                      description: description.isEmpty
                          ? 'New product'
                          : description,
                      price: price,
                      stock: stock,
                      icon: selectedIcon,
                    );
                    await addProduct(product);
                    Get.back<void>();
                  },
                  child: const Text('Add'),
                ),
              ),
            ],
          );
        },
      ),
      barrierDismissible: true,
    );

    titleController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    stockController.dispose();
  }

  @override
  Future<void> addProduct(PosProduct product) async {
    final user = FirebaseAuth.instance.currentUser;
    final uid = user?.uid;
    if (uid == null) {
      log("User not authenticated. Cannot add product.");
      return;
    }

    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('categories')
        .doc(presenter.selectedCategoryId)
        .collection('products')
        .doc(product.id)
        .set(product.toJson());

    presenter.products.add(product);
    presenter.update();
  }

  @override
  Future<void> onAddCategoryTap() async {
    log("Add category tapped");
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    String? errorText;
    IconData selectedIcon = Icons.category_outlined;
    const availableIcons = [
      Icons.category_outlined,
      Icons.photo_library_outlined,
      Icons.auto_awesome_outlined,
      Icons.checkroom_outlined,
      Icons.local_mall_outlined,
      Icons.palette_outlined,
      Icons.stars_outlined,
      Icons.emoji_emotions_outlined,
      Icons.push_pin_outlined,
      Icons.inventory_2_outlined,
      Icons.dashboard_customize_outlined,
      Icons.brush_outlined,
      Icons.sell_outlined,
      Icons.shopping_bag_outlined,
      Icons.layers_outlined,
      Icons.edit_outlined,
    ];

    String buildCategoryId(String title) {
      final base = title
          .trim()
          .toLowerCase()
          .replaceAll(RegExp(r'[^a-z0-9]+'), '-')
          .replaceAll(RegExp(r'^-+|-+$'), '');
      final fallback = base.isEmpty ? 'category' : base;
      final existingIds = presenter.categories.map((c) => c.id).toSet();
      var candidate = fallback;
      var suffix = 2;
      while (existingIds.contains(candidate)) {
        candidate = '$fallback-$suffix';
        suffix++;
      }
      return candidate;
    }

    await Get.dialog(
      StatefulBuilder(
        builder: (context, setState) {
          final theme = Theme.of(context);
          return AlertDialog(
            backgroundColor: CustomColors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            titlePadding: const EdgeInsets.fromLTRB(24, 24, 24, 8),
            contentPadding: const EdgeInsets.fromLTRB(24, 0, 24, 8),
            actionsPadding: const EdgeInsets.fromLTRB(24, 8, 24, 20),
            title: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: CustomColors.inputFill,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.category_outlined,
                    color: CustomColors.primary,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Add category',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: CustomColors.primaryText,
                    ),
                  ),
                ),
              ],
            ),
            content: SizedBox(
              width: 360,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Create a new category to keep your products organized.',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: CustomColors.mutedText,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: titleController,
                    textInputAction: TextInputAction.next,
                    autofocus: true,
                    decoration: InputDecoration(
                      labelText: 'Title',
                      errorText: errorText,
                      prefixIcon: const Icon(Icons.title),
                      filled: true,
                      fillColor: CustomColors.inputFill,
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: descriptionController,
                    keyboardType: TextInputType.multiline,
                    minLines: 3,
                    maxLines: 6,
                    decoration: const InputDecoration(
                      labelText: 'Description',
                      helperText: 'Optional',
                      prefixIcon: Icon(Icons.notes_outlined),
                      filled: true,
                      fillColor: CustomColors.inputFill,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Icon',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: CustomColors.primaryText,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      for (final icon in availableIcons)
                        InkWell(
                          borderRadius: BorderRadius.circular(12),
                          onTap: () {
                            setState(() {
                              selectedIcon = icon;
                            });
                          },
                          child: Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              color: CustomColors.inputFill,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: icon == selectedIcon
                                    ? CustomColors.primary
                                    : Colors.transparent,
                                width: 1.5,
                              ),
                            ),
                            child: Icon(
                              icon,
                              color: icon == selectedIcon
                                  ? CustomColors.primary
                                  : CustomColors.mutedText,
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
            actions: [
              SizedBox(
                height: 44,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: CustomColors.mutedText,
                    side: const BorderSide(color: CustomColors.inputFill),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () => Get.back<void>(),
                  child: const Text('Cancel'),
                ),
              ),
              const SizedBox(width: 8),
              SizedBox(
                height: 44,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: CustomColors.primary,
                    foregroundColor: CustomColors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () async {
                    final title = titleController.text.trim();
                    if (title.isEmpty) {
                      setState(() {
                        errorText = 'Title is required';
                      });
                      return;
                    }
                    final description = descriptionController.text.trim();
                    final category = PosCategory(
                      id: buildCategoryId(title),
                      title: title,
                      description: description.isEmpty
                          ? 'New category'
                          : description,
                      icon: selectedIcon,
                    );
                    await addCategory(category);
                    Get.back<void>();
                  },
                  child: const Text('Add'),
                ),
              ),
            ],
          );
        },
      ),
      barrierDismissible: true,
    );

    titleController.dispose();
    descriptionController.dispose();
  }

  @override
  Future<void> addCategory(PosCategory category) async {
    final user = FirebaseAuth.instance.currentUser;
    final uid = user?.uid;
    if (uid == null) {
      log("User not authenticated. Cannot add category.");
      return;
    }

    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('categories')
        .doc(category.id)
        .set(category.toJson());

    presenter.categories.add(category);
    presenter.update();
  }

  @override
  Future<void> onCategoryTap(String categoryId) async {
    log("Category tapped: $categoryId");
    presenter.selectedCategoryId = categoryId;

    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) {
      log('User not authenticated. Cannot load categories.');
      return;
    }

    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('categories')
        .doc(categoryId)
        .collection('products')
        .get();
    final products = <PosProduct>[];
    for (final doc in snapshot.docs) {
      products.add(PosProduct.fromJson(doc.data()));
    }
    presenter.products.assignAll(products);

    log("Loaded ${products.length} products for category $categoryId");

    presenter.filteredProducts = presenter.products
        .where((product) => product.categoryId == categoryId)
        .toList();
  }

  @override
  Future<void> onAddToCart(PosProduct product) async {
    log("Add to cart tapped: ${product.title} (Qty: ${product.quantity})");
    presenter.cartItems.add(PosProduct.copyWith(product));
    presenter.cartTotal += product.price * product.quantity;
    presenter.update();
  }

  @override
  Future<void> onCheckoutTap() async {
    log("Checkout tapped");
    if (presenter.cartItems.isEmpty) {
      log("Cart is empty. Nothing to checkout.");
      return;
    }

    final cashController = TextEditingController();
    String? cashErrorText;
    final total = presenter.cartTotal;
    double cashReceived = 0;
    double changeDue = 0;

    await Get.dialog(
      StatefulBuilder(
        builder: (context, setState) {
          final theme = Theme.of(context);
          return AlertDialog(
            backgroundColor: CustomColors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            titlePadding: const EdgeInsets.fromLTRB(24, 24, 24, 8),
            contentPadding: const EdgeInsets.fromLTRB(24, 0, 24, 8),
            actionsPadding: const EdgeInsets.fromLTRB(24, 8, 24, 20),
            title: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: CustomColors.inputFill,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.point_of_sale_outlined,
                    color: CustomColors.primary,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Confirm checkout',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: CustomColors.primaryText,
                    ),
                  ),
                ),
              ],
            ),
            content: SizedBox(
              width: 360,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Total due: \$${total.toStringAsFixed(2)}',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: CustomColors.primaryText,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: cashController,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    decoration: InputDecoration(
                      labelText: 'Cash received',
                      errorText: cashErrorText,
                      prefixIcon: const Icon(Icons.payments_outlined),
                      filled: true,
                      fillColor: CustomColors.inputFill,
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                    ),
                    onChanged: (value) {
                      final parsed = double.tryParse(value.trim());
                      setState(() {
                        cashErrorText = null;
                        cashReceived = parsed ?? 0;
                        changeDue =
                            cashReceived >= total ? cashReceived - total : 0;
                      });
                    },
                  ),
                  const SizedBox(height: 12),
                  if (changeDue > 0)
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Change due: \$${changeDue.toStringAsFixed(2)}',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: CustomColors.mutedText,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            actions: [
              SizedBox(
                height: 44,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: CustomColors.mutedText,
                    side: const BorderSide(color: CustomColors.inputFill),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () => Get.back<void>(),
                  child: const Text('Cancel'),
                ),
              ),
              const SizedBox(width: 8),
              SizedBox(
                height: 44,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: CustomColors.primary,
                    foregroundColor: CustomColors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () async {
                    final cashText = cashController.text.trim();
                    final parsed = double.tryParse(cashText);
                    if (parsed == null) {
                      setState(() {
                        cashErrorText = 'Enter a valid amount';
                      });
                      return;
                    }
                    if (parsed < total) {
                      setState(() {
                        cashErrorText = 'Cash received is less than total';
                      });
                      return;
                    }
                    await onCheckout();
                    Get.back<void>();
                  },
                  child: const Text('Confirm'),
                ),
              ),
            ],
          );
        },
      ),
      barrierDismissible: true,
    );

    cashController.dispose();
  }

  @override
  Future<void> onCheckout() async {
    log("Checkout processing...");
    final user = FirebaseAuth.instance.currentUser;
    final uid = user?.uid;
    if (uid == null) {
      log("User not authenticated. Cannot checkout.");
      return;
    }

    if (presenter.cartItems.isEmpty) {
      log("Cart is empty. Nothing to checkout.");
      return;
    }

    final items = presenter.cartItems
        .map(
          (item) => {
            ...item.toJson(),
            'quantity': item.quantity,
            'lineTotal': item.price * item.quantity,
          },
        )
        .toList();

    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('orders')
        .add({
          'items': items,
          'total': presenter.cartTotal,
          'createdAt': FieldValue.serverTimestamp(),
        });

    presenter.cartItems.clear();
    presenter.cartTotal = 0;
    presenter.selectedQuantities.clear();
    presenter.update();
  }
}
