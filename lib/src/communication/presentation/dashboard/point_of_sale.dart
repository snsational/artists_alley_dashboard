import 'dart:developer';

import 'package:artists_alley_dashboard/src/data/data.dart';
import 'package:artists_alley_dashboard/src/presentation/presentation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class PointOfSaleViewPresentation extends PointOfSaleViewPresenter
    with GetSingleTickerProviderStateMixin {
  PointOfSaleViewPresentation() {
    _initPresenter();
  }

  final RxList<PosCategory> _categories = <PosCategory>[].obs;
  @override
  List<PosCategory> get categories => _categories;
  @override
  set categories(List<PosCategory> value) => _categories.value = value;

  final RxList<PosProduct> _products = <PosProduct>[].obs;
  @override
  List<PosProduct> get products => _products;
  @override
  set products(List<PosProduct> value) => _products.value = value;

  final RxnString _selectedCategoryId = RxnString("");
  @override
  String? get selectedCategoryId => _selectedCategoryId.value;
  @override
  set selectedCategoryId(String? value) => _selectedCategoryId.value = value;

  final RxMap<String, int> _selectedQuantities = <String, int>{}.obs;
  @override
  Map<String, int> get selectedQuantities => _selectedQuantities;
  @override
  set selectedQuantities(Map<String, int> value) =>
      _selectedQuantities.value = value;

  final RxDouble _cartTotal = 0.0.obs;
  @override
  double get cartTotal => _cartTotal.value;
  @override
  set cartTotal(double value) => _cartTotal.value = value;

  final RxList<PosProduct> _cartItems = <PosProduct>[].obs;
  @override
  set cartItems(List<PosProduct> value) => _cartItems.value = value;
  @override
  List<PosProduct> get cartItems => _cartItems;

  final RxList<PosProduct> _filteredProducts = <PosProduct>[].obs;
  @override
  set filteredProducts(List<PosProduct> value) =>
      _filteredProducts.value = value;
  @override
  List<PosProduct> get filteredProducts {
    final selected = _selectedCategoryId.value;
    if (selected == null) {
      return _products;
    }
    return _products
        .where((product) => product.categoryId == selected)
        .toList();
  }

  Future<void> _initPresenter() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) {
      log('User not authenticated. Cannot load categories.');
      return;
    }

    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('categories')
        .get();
    final categories = <PosCategory>[];
    for (final doc in snapshot.docs) {
      categories.add(PosCategory.fromJson(doc.data()));
    }
    _categories.assignAll(categories);
    if (_categories.isNotEmpty && _selectedCategoryId.value == null) {
      _selectedCategoryId.value = _categories.first.id;
    }
  }
}
