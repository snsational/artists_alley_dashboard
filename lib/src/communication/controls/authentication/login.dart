import 'dart:developer';
import 'package:artists_alley_dashboard/src/config/constants/constants.dart';
import 'package:artists_alley_dashboard/src/domain/repositories/repositories.dart';
import 'package:artists_alley_dashboard/src/presentation/presentation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginViewControl implements LoginViewController {
  final LoginViewPresenter _presenter;
  final AuthenticationRepository _repository;

  LoginViewControl(this._presenter, this._repository);

  @override
  void togglePasswordVisibility() {
    _presenter.isPasswordVisible = !_presenter.isPasswordVisible;
  }

  @override
  void onCheckRememberMe(bool? value) {
    _presenter.isRememberMeChecked = value ?? false;
  }

  @override
  void goToRecoverPassword() {
    log(name: "LoginViewControl", "Navigating to Forgot Password View...");
    Get.rootDelegate.toNamed(Routes.forgotPassword);
  }

  @override
  Future<void> toggleLocale(BuildContext context) async {
    final delegate = LocalizedApp.of(context).delegate;
    final nextLang = isPortuguese(context) ? 'en' : 'pt';
    await delegate.changeLocale(localeFromString(nextLang));
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(LocalStorageKeys.lang, nextLang);
    _presenter.locale = nextLang;
    log(name: "LoginViewControl", "Locale changed to: $nextLang");
  }

  @override
  bool isPortuguese(BuildContext context) {
    final currentLocale = LocalizedApp.of(context).delegate.currentLocale;
    log(name: "LoginViewControl", "Current locale: $currentLocale");
    return currentLocale.languageCode == 'pt';
  }

  @override
  Future<void> onLogin() async {
    _presenter.isLoading = true;
    try {
      // Handle successful login (e.g., navigate to dashboard)
    } catch (e) {
      // Handle login error (e.g., show error message)
    } finally {
      _presenter.isLoading = false;
    }
  }

  @override
  Future<void> signInWithGoogle() async {
    try {
      final UserCredential cred = await _repository.signInWithGoogle();
      final user = cred.user;

      Get.rootDelegate.toNamed(Routes.dashboard);
      log('Signed in: ${user?.email}');
      final uid = FirebaseAuth.instance.currentUser!.uid;
      log('UID: $uid');
      final docRef = FirebaseFirestore.instance.collection('users').doc(uid);

      final doc = await docRef.get();

      if (!doc.exists) {
        await docRef.set({'createdAt': FieldValue.serverTimestamp()});
      }
    } catch (e) {
      log('Google sign-in failed: $e');
    }
  }
}
