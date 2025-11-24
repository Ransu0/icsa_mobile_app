import 'package:flutter/material.dart';
import 'package:icsa_mobile_app/src/common/widgets/navigation_bar.dart';
import 'package:icsa_mobile_app/src/core/theme/app_spacing.dart';
import 'package:icsa_mobile_app/src/core/theme/app_text_styles.dart';

import 'package:icsa_mobile_app/src/core/theme/theme_provider.dart';
import 'package:icsa_mobile_app/src/features/admin/presentation/widgets/card_section.dart';
import 'package:icsa_mobile_app/src/features/admin/presentation/widgets/header_section.dart';

import 'package:provider/provider.dart';

class AdminDashboardPage extends StatelessWidget {
  const AdminDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      bottomNavigationBar: const CustomNavBar(),
      backgroundColor: colorScheme.surface,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Admin Dashboard",
              style: AppTextStyles.heading1
                ..copyWith(color: Theme.of(context).colorScheme.onSurface),
            ),
            const SizedBox(height: 10),
            const AdminHeaderSection(),
            const SizedBox(height: 20),
            const AdminCardSection(),
          ],
        ),
      ),
    );
  }
}
