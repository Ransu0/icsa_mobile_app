import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:icsa_mobile_app/src/core/theme/app_spacing.dart';
import 'package:icsa_mobile_app/src/core/theme/app_text_styles.dart';

class AdminSearchBar extends StatelessWidget {
  const AdminSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      children: [
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search,
                  color: Theme.of(context).colorScheme.secondary),
              hintText: 'Search Student',
              hintStyle: AppTextStyles.body
                  .copyWith(color: Theme.of(context).colorScheme.secondary),
              filled: true,
              fillColor: colorScheme.surface,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSpacing.borderRadius),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        const SizedBox(width: 8.0),
        FloatingActionButton(
          onPressed: () => context.go("/admin/students/add-student"),
          tooltip: "Add New Student",
          child: const Icon(Icons.add),
        ),
      ],
    );
  }
}
