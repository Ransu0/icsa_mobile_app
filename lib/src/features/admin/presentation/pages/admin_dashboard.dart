import 'package:flutter/material.dart';
import 'package:icsa_mobile_app/src/common/widgets/navigation_bar.dart';
import 'package:icsa_mobile_app/src/core/theme/app_spacing.dart';
import 'package:icsa_mobile_app/src/core/theme/theme_provider.dart';
import 'package:icsa_mobile_app/src/features/admin/presentation/widgets/card_section.dart';
import 'package:icsa_mobile_app/src/features/admin/presentation/widgets/header_section.dart';
import 'package:icsa_mobile_app/src/features/admin/presentation/widgets/search_bar.dart';
import 'package:provider/provider.dart';

class AdminDashboardPage extends StatelessWidget {
  const AdminDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      bottomNavigationBar: const CustomNavBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.lg, vertical: AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AdminHeaderSection(),
              const SizedBox(height: AppSpacing.lg),
              const AdminSearchBar(),
              const SizedBox(height: AppSpacing.lg),
              const AdminCardSection(),
              const SizedBox(height: AppSpacing.lg),
            ],
          ),
        ),
      ),
    );
  }
}
