import 'package:artists_alley_dashboard/src/components/components.dart';
import 'package:artists_alley_dashboard/src/config/constants/constants.dart';
import 'package:artists_alley_dashboard/src/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PosMainColumn extends StatelessWidget {
  const PosMainColumn({
    super.key,
    required this.presenter,
    required this.controller,
  });

  final PointOfSaleViewPresenter presenter;
  final PointOfSaleViewController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        PosHeader(controller: controller, presenter: presenter),
        const SizedBox(height: 24),
        Obx(() {
          final selected = presenter.selectedCategoryId;
          final hasSelection = selected != null && selected.isNotEmpty;
          if (!hasSelection) {
            return const SizedBox.shrink();
          }
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Align(
              alignment: Alignment.centerLeft,
              child: TextButton.icon(
                onPressed: () {
                  presenter.selectedCategoryId = "";
                },
                style: TextButton.styleFrom(
                  foregroundColor: CustomColors.mutedText,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                ),
                icon: const Icon(Icons.chevron_left),
                label: const Text('All Categories'),
              ),
            ),
          );
        }),
        PosSection(
          child: PosCategoryGrid(presenter: presenter, controller: controller),
        ),
      ],
    );
  }
}
