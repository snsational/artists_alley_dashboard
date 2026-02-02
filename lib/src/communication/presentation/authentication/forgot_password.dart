import 'package:artists_alley_dashboard/src/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordViewPresentation extends ForgotPasswordViewPresenter
    with GetSingleTickerProviderStateMixin {
  ForgotPasswordViewPresentation();

  @override
  final emailController = TextEditingController();
  @override
  final formKey = GlobalKey<FormState>();
}
