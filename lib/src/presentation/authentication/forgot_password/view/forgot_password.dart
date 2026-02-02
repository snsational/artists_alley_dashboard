import 'package:artists_alley_dashboard/src/config/constants/constants.dart';
import 'package:artists_alley_dashboard/src/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';

class ForgotPasswordView
    extends
        CustomGetView<
          ForgotPasswordViewController,
          ForgotPasswordViewPresenter
        > {
  const ForgotPasswordView({super.key});

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
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 460),
                  child: Material(
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
                            alignment: Alignment.centerLeft,
                            child: TextButton.icon(
                              onPressed: controller.back,
                              icon: const Icon(Icons.arrow_back),
                              label: Text(
                                translate('forgot_password.back_to_login'),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            translate('forgot_password.title'),
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
                            translate('forgot_password.subtitle'),
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(color: CustomColors.mutedText),
                          ),
                          const SizedBox(height: 24),
                          TextFormField(
                            controller: presenter.emailController,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.done,
                            decoration: InputDecoration(
                              labelText: translate(
                                'forgot_password.email_field.label',
                              ),
                              prefixIcon: const Icon(Icons.alternate_email),
                              filled: true,
                              fillColor: CustomColors.inputFill,
                              border: const OutlineInputBorder(),
                            ),
                            validator: (value) {
                              final trimmed = value?.trim() ?? '';
                              if (trimmed.isEmpty) {
                                return translate(
                                  'forgot_password.email_field.error_empty',
                                );
                              }
                              if (!trimmed.contains('@')) {
                                return translate(
                                  'forgot_password.email_field.error_invalid',
                                );
                              }
                              return null;
                            },
                            onFieldSubmitted: (_) => _submitEmail(),
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            height: 48,
                            child: ElevatedButton(
                              onPressed: _submitEmail,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: CustomColors.primary,
                                foregroundColor: CustomColors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Text(
                                translate('forgot_password.submit_button'),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            translate('forgot_password.support_text'),
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(color: CustomColors.mutedText),
                          ),
                          ],
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

  void _submitEmail() {
    controller.onSubmitEmail();
  }
}
