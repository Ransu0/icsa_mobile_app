import 'package:flutter/material.dart';
import 'package:icsa_mobile_app/src/core/theme/app_spacing.dart';
import 'package:icsa_mobile_app/src/core/theme/app_text_styles.dart';

class authCategorySection extends StatelessWidget {
  const authCategorySection({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = [
      {'icon': Icons.people, 'label': 'Students'},
      {'icon': Icons.book, 'label': 'Courses'},
      {'icon': Icons.event, 'label': 'Events'},
      {'icon': Icons.admin_panel_settings, 'label': 'Admins'},
    ];

    return SizedBox(
      height: 80,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.md),
        itemBuilder: (context, index) {
          final category = categories[index];
          return Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(AppSpacing.borderRadius),
                ),
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Icon(category['icon'] as IconData,
                    color: Theme.of(context).colorScheme.primary, size: 28),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                category['label'] as String,
                style: AppTextStyles.body
                    .copyWith(color: Theme.of(context).colorScheme.primary),
              ),
            ],
          );
        },
      ),
    );
  }
}
