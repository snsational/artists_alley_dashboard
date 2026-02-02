import 'package:artists_alley_dashboard/src/communication/communication.dart';
import 'package:artists_alley_dashboard/src/domain/domain.dart';
import 'package:artists_alley_dashboard/src/domain/usecases/authentication.dart';
import 'package:artists_alley_dashboard/src/presentation/presentation.dart';
import 'package:artists_alley_dashboard/src/utils/watchers/maintenance_watcher.dart';
import 'package:get/get.dart';

class CustomBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(MaintenanceWatcher(), permanent: true);

    // Login
    Get.lazyPut<LoginViewController>(
      () => LoginViewControl(
        Get.find<LoginViewPresenter>(),
        Get.find<AuthenticationRepository>(),
      ),
      fenix: true,
    );
    Get.lazyPut<LoginViewPresenter>(() => LoginViewPresentation(), fenix: true);

    Get.lazyPut<AuthenticationRepository>(
      () => AuthenticationUsecase(),
      fenix: true,
    );

    // Forgot Password
    Get.lazyPut<ForgotPasswordViewController>(
      () => ForgotPasswordViewControl(Get.find<ForgotPasswordViewPresenter>()),
      fenix: true,
    );
    Get.lazyPut<ForgotPasswordViewPresenter>(
      () => ForgotPasswordViewPresentation(),
      fenix: true,
    );

    // Dashboard - Home
    Get.lazyPut<HomeViewController>(() => HomeViewControl(), fenix: true);
    Get.lazyPut<HomeViewPresenter>(() => HomeViewPresentation(), fenix: true);

    // Dashboard - Point of Sale
    Get.lazyPut<PointOfSaleViewController>(
      () => PointOfSaleViewControl(Get.find<PointOfSaleViewPresenter>()),
      fenix: true,
    );
    Get.lazyPut<PointOfSaleViewPresenter>(
      () => PointOfSaleViewPresentation(),
      fenix: true,
    );
  }
}
