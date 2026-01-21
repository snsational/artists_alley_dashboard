import 'package:artists_alley_dashboard/src/config/constants/constants.dart';
import 'package:artists_alley_dashboard/src/presentation/authentication/login/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:get/get.dart';

class LoginView extends CustomGetView<LoginViewController, LoginViewPresenter> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              CustomColors.loginGradientStart,
              CustomColors.loginGradientEnd,
            ],
          ),
        ),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isWideLayout = constraints.maxWidth >= 900;
              final content = SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 32,
                ),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 460),
                  child: Obx(
                    () => Material(
                      elevation: 10,
                      borderRadius: BorderRadius.circular(24),
                      color: CustomColors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(28),
                        child: Form(
                          key: presenter.formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                  onPressed: () =>
                                      controller.toggleLocale(context),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        presenter.locale == 'en'
                                            ? '🇺🇸'
                                            : '🇵🇹',
                                        style: const TextStyle(fontSize: 20),
                                      ),
                                      const SizedBox(width: 4),
                                      Text(presenter.locale.toUpperCase()),
                                    ],
                                  ),
                                ),
                              ),
                              Text(
                                translate("login.welcome_back"),
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.w700,
                                      color: CustomColors.primaryText,
                                    ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                translate('login.sign_in_to_continue'),
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(color: CustomColors.mutedText),
                              ),
                              const SizedBox(height: 24),
                              TextFormField(
                                controller: presenter.emailController,
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  labelText: translate(
                                    'login.email_field.label',
                                  ),
                                  prefixIcon: Icon(Icons.alternate_email),
                                  filled: true,
                                  fillColor: CustomColors.inputFill,
                                  border: OutlineInputBorder(),
                                ),
                                validator: (value) {
                                  final trimmed = value?.trim() ?? '';
                                  if (trimmed.isEmpty) {
                                    return translate(
                                      'login.email_field.error_empty',
                                    );
                                  }
                                  if (!trimmed.contains('@')) {
                                    return translate(
                                      'login.email_field.error_invalid',
                                    );
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 16),
                              TextFormField(
                                controller: presenter.passwordController,
                                obscureText: !presenter.isPasswordVisible,
                                textInputAction: TextInputAction.done,
                                decoration: InputDecoration(
                                  labelText: translate(
                                    'login.password_field.label',
                                  ),
                                  prefixIcon: const Icon(Icons.lock_outline),
                                  suffixIcon: IconButton(
                                    onPressed:
                                        controller.togglePasswordVisibility,
                                    icon: Icon(
                                      presenter.isPasswordVisible
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                    ),
                                  ),
                                  filled: true,
                                  fillColor: CustomColors.inputFill,
                                  border: const OutlineInputBorder(),
                                ),
                                validator: (value) {
                                  final trimmed = value ?? '';
                                  if (trimmed.isEmpty) {
                                    return translate(
                                      'login.password_field.error_empty',
                                    );
                                  }
                                  if (trimmed.length < 6) {
                                    return translate(
                                      'login.password_field.error_too_short',
                                    );
                                  }
                                  return null;
                                },
                                onFieldSubmitted: (_) => _submitLogin(),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Checkbox(
                                    value: presenter.isRememberMeChecked,
                                    onChanged: controller.onCheckRememberMe,
                                    activeColor: CustomColors.primary,
                                  ),
                                  Text(translate('login.remember_me')),
                                  const Spacer(),
                                  TextButton(
                                    onPressed: controller.goToRecoverPassword,
                                    child: Text(
                                      translate('login.forgot_password'),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              SizedBox(
                                height: 48,
                                child: ElevatedButton(
                                  onPressed: presenter.isLoading
                                      ? null
                                      : _submitLogin,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: CustomColors.primary,
                                    foregroundColor: CustomColors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: presenter.isLoading
                                      ? const SizedBox(
                                          width: 22,
                                          height: 22,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                                  CustomColors.white,
                                                ),
                                          ),
                                        )
                                      : Text(translate('login.sign_in_button')),
                                ),
                              ),
                              const SizedBox(height: 16),
                              SizedBox(
                                height: 48,
                                child: OutlinedButton(
                                  onPressed: presenter.isLoading
                                      ? null
                                      : controller.signInWithGoogle,
                                  style: OutlinedButton.styleFrom(
                                    backgroundColor: CustomColors.white,
                                    foregroundColor: CustomColors.mutedText,
                                    side: const BorderSide(
                                      color: CustomColors.inputFill,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 22,
                                        height: 22,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: CustomColors.white,
                                          borderRadius: BorderRadius.circular(
                                            6,
                                          ),
                                          border: Border.all(
                                            color: CustomColors.inputFill,
                                          ),
                                        ),
                                        child: Image.asset(
                                          'assets/images/google-logo.png',
                                          width: 16,
                                          height: 16,
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Text(
                                        translate(
                                          'login.google_sign_in_button',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 24),
                              Text(
                                translate('login.no_account'),
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.bodySmall
                                    ?.copyWith(color: CustomColors.mutedText),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );

              if (!isWideLayout) {
                return Center(child: content);
              }

              return Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 48,
                        right: 24,
                        top: 32,
                        bottom: 32,
                      ),
                      child: Container(
                        constraints: const BoxConstraints(maxWidth: 560),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(32),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: const Placeholder(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 24, right: 64),
                    child: content,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  void _submitLogin() {
    if (presenter.formKey.currentState?.validate() ?? false) {
      controller.onLogin();
    }
  }
}
