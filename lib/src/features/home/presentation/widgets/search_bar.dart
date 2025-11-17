import 'package:flutter/material.dart';
import 'package:icsa_mobile_app/src/core/theme/app_color.dart';
import 'package:icsa_mobile_app/src/core/theme/app_spacing.dart';
import 'package:icsa_mobile_app/src/core/theme/app_text_styles.dart';

class AuthSearchBar extends StatelessWidget {
  const AuthSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return TextField(
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.search, color: AppColors.textSecondary),
        hintText: 'Search Student',
        hintStyle: AppTextStyles.body.copyWith(color: AppColors.textSecondary),
        filled: true,
        fillColor: colorScheme.surface,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.borderRadius),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
