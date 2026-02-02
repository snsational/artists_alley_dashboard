import 'dart:developer';

import 'package:artists_alley_dashboard/src/presentation/presentation.dart';
import 'package:get/get.dart';

class ForgotPasswordViewControl implements ForgotPasswordViewController {
  final ForgotPasswordViewPresenter _presenter;

  ForgotPasswordViewControl(this._presenter);

  @override
  Future<void> onSubmitEmail() async {
    if (_presenter.formKey.currentState?.validate() ?? false) {
      final email = _presenter.emailController.text.trim();
      // Implement the logic to handle password reset email submission
      // For example, call an API to send the reset email
      log('Password reset email submitted for: $email');
    }
  }

  @override
  void back() {
    // Implement navigation logic to go back to the previous screen
    Get.rootDelegate.popRoute();
  }
}
