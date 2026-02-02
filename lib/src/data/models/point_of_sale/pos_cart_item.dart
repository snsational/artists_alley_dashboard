import 'package:artists_alley_dashboard/src/data/data.dart';

class PosCartItem {
  const PosCartItem({required this.product, required this.quantity});

  final PosProduct product;
  final int quantity;

  double get lineTotal => product.price * quantity;
}
