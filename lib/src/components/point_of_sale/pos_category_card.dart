import 'package:artists_alley_dashboard/src/components/components.dart';
import 'package:artists_alley_dashboard/src/config/constants/constants.dart';
import 'package:artists_alley_dashboard/src/data/data.dart';
import 'package:flutter/material.dart';

class PosCategoryCard extends StatelessWidget {
  const PosCategoryCard({
    super.key,
    required this.category,
    required this.onTap,
  });

  final PosCategory category;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.bodyLarge?.copyWith(
      fontWeight: FontWeight.w600,
      color: CustomColors.primaryText,
    );
    final subtitleStyle = Theme.of(
      context,
    ).textTheme.bodySmall?.copyWith(color: CustomColors.mutedText);
    return PosCard(
      padding: EdgeInsets.zero,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: CustomColors.primary.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(category.icon, color: CustomColors.primary),
                  ),
                  const SizedBox(width: 12),
                  Expanded(child: Text(category.title, style: titleStyle)),
                ],
              ),
              const SizedBox(height: 8),
              Text(category.description, style: subtitleStyle),
            ],
          ),
        ),
      ),
    );
  }
}
