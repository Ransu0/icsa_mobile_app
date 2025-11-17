import 'package:flutter/material.dart';
import 'package:icsa_mobile_app/src/core/theme/app_color.dart';
import 'package:icsa_mobile_app/src/core/theme/app_text_styles.dart';

class AdminHeaderSection extends StatelessWidget {
  const AdminHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Hello,',
                style: AppTextStyles.subtitle
                    .copyWith(color: AppColors.textSecondary)),
            Text(
              'Dominick!',
              style: AppTextStyles.headline1
                  .copyWith(color: AppColors.textPrimary),
            ),
          ],
        ),
        const CircleAvatar(
          radius: 22,
          backgroundImage: AssetImage('images/profile.png'),
        ),
      ],
    );
  }
}
