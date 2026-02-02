import 'dart:developer';

import 'package:artists_alley_dashboard/src/config/constants/constants.dart';
import 'package:artists_alley_dashboard/src/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginViewPresentation extends LoginViewPresenter
    with GetSingleTickerProviderStateMixin {
  LoginViewPresentation() {
    _getSavedValues();
  }

  @override
  final emailController = TextEditingController();
  @override
  final passwordController = TextEditingController();
  @override
  final formKey = GlobalKey<FormState>();

  final RxBool _isRememberMeChecked = false.obs;
  @override
  bool get isRememberMeChecked => _isRememberMeChecked.value;
  @override
  set isRememberMeChecked(bool value) => _isRememberMeChecked.value = value;

  final RxBool _isPasswordVisible = false.obs;
  @override
  bool get isPasswordVisible => _isPasswordVisible.value;
  @override
  set isPasswordVisible(bool value) => _isPasswordVisible.value = value;

  final RxBool _isLoading = false.obs;
  @override
  bool get isLoading => _isLoading.value;
  @override
  set isLoading(bool value) => _isLoading.value = value;

  final RxString _locale = 'en'.obs;
  @override
  String get locale => _locale.value;
  @override
  set locale(String value) => _locale.value = value;

  Future<void> _getSavedValues() async {
    try {
      _isLoading.value = true;
      final prefs = await SharedPreferences.getInstance();
      final bool rememberMe =
          prefs.getBool(LocalStorageKeys.rememberMe) ?? false;
      if (rememberMe) {
        _isRememberMeChecked.value = rememberMe;
        final String email = prefs.getString(LocalStorageKeys.email) ?? '';
        emailController.text = email;
      }
      final String locale = prefs.getString(LocalStorageKeys.lang) ?? 'en';
      _locale.value = locale;
      _isLoading.value = false;
    } catch (e) {
      log(
        name: "LoginViewPresentation _getSavedValues",
        "Error getting saved values: $e",
      );
      _isLoading.value = false;
    }
  }
}
