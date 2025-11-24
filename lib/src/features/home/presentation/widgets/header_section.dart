import 'package:flutter/material.dart';
import 'package:icsa_mobile_app/src/core/theme/app_text_styles.dart';

class AuthHeaderSection extends StatelessWidget {
  const AuthHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Hello,',
                style: AppTextStyles.subtitle.copyWith(
                    color: Theme.of(context).colorScheme.onSecondary)),
            Text(
              'Dominick!',
              style: AppTextStyles.heading1
                  .copyWith(color: Theme.of(context).colorScheme.primary),
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
