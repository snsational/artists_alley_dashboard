import 'package:artists_alley_dashboard/src/data/data.dart';

abstract class PointOfSaleViewController {
  Future<void> onCategoryTap(String categoryId);
  Future<void> onAddCategoryTap();
  Future<void> addCategory(PosCategory category);
  Future<void> onProductTap(String productId);
  Future<void> onAddProductTap();
  Future<void> addProduct(PosProduct product);
  Future<void> onAddToCart(PosProduct product);
  Future<void> onCheckoutTap();
  Future<void> onCheckout();
}
