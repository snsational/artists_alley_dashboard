import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class LoginViewPresenter extends GetxController {
  TextEditingController get emailController;
  TextEditingController get passwordController;
  GlobalKey<FormState> get formKey;

  bool get isPasswordVisible;
  set isPasswordVisible(bool value);

  bool get isRememberMeChecked;
  set isRememberMeChecked(bool value);

  bool get isLoading;
  set isLoading(bool value);

  String get locale;
  set locale(String value);
}
