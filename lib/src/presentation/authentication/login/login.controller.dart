import 'package:flutter/material.dart';

abstract class LoginViewController {
  void togglePasswordVisibility();
  void onCheckRememberMe(bool? value);
  void goToRecoverPassword();
  Future<void> signInWithGoogle();
  Future<void> onLogin();
  Future<void> toggleLocale(BuildContext context);
  bool isPortuguese(BuildContext context);
}
