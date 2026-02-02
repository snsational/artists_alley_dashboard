import 'package:artists_alley_dashboard/src/components/components.dart';
import 'package:artists_alley_dashboard/src/config/constants/constants.dart';
import 'package:artists_alley_dashboard/src/presentation/presentation.dart';
import 'package:flutter/material.dart';

class PointOfSaleView
    extends CustomGetView<PointOfSaleViewController, PointOfSaleViewPresenter> {
  const PointOfSaleView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWideLayout = constraints.maxWidth >= 1100;
          final horizontalPadding = isWideLayout ? 48.0 : 24.0;
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Container(
                width: double.infinity,
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
                  minimum: const EdgeInsets.only(bottom: 24),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: horizontalPadding,
                      vertical: 32,
                    ),
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 1200),
                        child: isWideLayout
                            ? Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: PosMainColumn(
                                      presenter: presenter,
                                      controller: controller,
                                    ),
                                  ),
                                  const SizedBox(width: 32),
                                  SizedBox(
                                    width: 340,
                                    child: PosCartColumn(
                                      presenter: presenter,
                                      controller: controller,
                                    ),
                                  ),
                                ],
                              )
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  PosMainColumn(
                                    presenter: presenter,
                                    controller: controller,
                                  ),
                                  const SizedBox(height: 24),
                                  PosCartColumn(
                                    presenter: presenter,
                                    controller: controller,
                                  ),
                                ],
                              ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
