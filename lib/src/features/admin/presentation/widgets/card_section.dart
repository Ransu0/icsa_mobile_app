import 'package:flutter/material.dart';
import 'package:icsa_mobile_app/src/common/widgets/cards/info_card.dart';
import 'package:icsa_mobile_app/src/core/theme/app_spacing.dart';

class AdminCardSection extends StatelessWidget {
  const AdminCardSection({super.key});

  @override
  Widget build(BuildContext context) {
    // For this template, we'll just create a fixed number of items
    return Container(
      child: Column(
        spacing: AppSpacing.lg,
        children: [
          Row(
            spacing: AppSpacing.md,
            children: [InfoCard(), InfoCard()],
          ),
          Row(
            spacing: AppSpacing.md,
            children: [InfoCard(), InfoCard()],
          )
        ],
      ),
    );
  }
}
