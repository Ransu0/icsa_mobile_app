import 'package:flutter/material.dart';
import 'package:icsa_mobile_app/src/core/theme/app_color.dart';
import 'package:icsa_mobile_app/src/core/theme/app_text_styles.dart';

class NoPageFound extends StatelessWidget {
  const NoPageFound({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 1. ILLUSTRATION
              // Since we don't have the exact ghost asset, I'm using an Icon
              // wrapped in a container. Replace this with:
              // Image.asset('assets/ghost_illustration.png', height: 200)
              Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                  color: AppColors.lightPrimary.withValues(alpha: .05),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons
                      .sentiment_dissatisfied_rounded, // Placeholder for the ghost
                  size: 100,
                  color: AppColors.lightPrimary.withValues(alpha: .5),
                ),
              ),

              const SizedBox(height: 40),

              // 2. HEADLINE
              const Text(
                "Whoops!",
                style: AppTextStyles.heading1,
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 16),

              // 3. DESCRIPTION
              Text(
                "We couldn't find the page\nyou were looking for.",
                style: AppTextStyles.body,
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 60),

              // 4. "GO HOME" BUTTON
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate back to home
                    // Navigator.pop(context); OR Navigator.pushNamed(context, '/home');
                    debugPrint("Navigating to Home...");
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.lightPrimary,
                    foregroundColor: Colors.white,
                    elevation: 0, // Flat style as per modern design trends
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        16,
                      ), // Soft rounded corners
                    ),
                    shadowColor: Theme.of(context)
                        .colorScheme
                        .primary
                        .withValues(alpha: .4),
                  ),
                  child: const Text("Go Home", style: AppTextStyles.body),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
