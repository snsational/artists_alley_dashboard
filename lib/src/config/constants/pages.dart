import 'package:artists_alley_dashboard/src/presentation/presentation.dart';
import 'package:get/get.dart';
import 'constants.dart';

class Pages {
  Pages._();

  static final pages = [
    GetPage(
      name: Routes.login,
      page: () => const LoginView(),
      preventDuplicates: true,
      participatesInRootNavigator: true,
    ),
    GetPage(
      name: Routes.forgotPassword,
      page: () => const ForgotPasswordView(),
      preventDuplicates: true,
      participatesInRootNavigator: true,
    ),
    GetPage(
      name: Routes.dashboard,
      page: () => const HomeView(),
      preventDuplicates: true,
      participatesInRootNavigator: true,
    ),
  ];
}
