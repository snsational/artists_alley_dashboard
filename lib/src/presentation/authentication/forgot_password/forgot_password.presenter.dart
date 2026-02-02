import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class ForgotPasswordViewPresenter extends GetxController {
  TextEditingController get emailController;
  GlobalKey<FormState> get formKey;
}
