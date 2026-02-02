import 'package:artists_alley_dashboard/src/data/data.dart';
import 'package:get/get.dart';

abstract class PointOfSaleViewPresenter extends GetxController {
  List<PosCategory> get categories;
  set categories(List<PosCategory> value);

  List<PosProduct> get products;
  set products(List<PosProduct> value);

  List<PosProduct> get filteredProducts;
  set filteredProducts(List<PosProduct> value);

  String? get selectedCategoryId;
  set selectedCategoryId(String? value);

  Map<String, int> get selectedQuantities;
  set selectedQuantities(Map<String, int> value);

  List<PosProduct> get cartItems;
  set cartItems(List<PosProduct> value);

  double get cartTotal;
  set cartTotal(double value);
}
