import 'package:artists_alley_dashboard/src/config/constants/routes.dart';
import 'package:artists_alley_dashboard/src/presentation/presentation.dart';
import 'package:get/get.dart';

class HomeViewControl implements HomeViewController {
  HomeViewControl();

  @override
  Future<void> onLogout() {
    // TODO: implement onLogout
    throw UnimplementedError();
  }

  @override
  Future<void> onPointOfSaleTap() async {
    Get.rootDelegate.toNamed(Routes.pointOfSale);
  }
}
