import 'package:get/get.dart';

abstract class HomeViewPresenter extends GetxController {
  double get totalSales;
  set totalSales(double value);

  int get totalOrders;
  set totalOrders(int value);
}
