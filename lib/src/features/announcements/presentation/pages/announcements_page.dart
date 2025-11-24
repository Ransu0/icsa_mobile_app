import 'package:flutter/material.dart';
import 'package:icsa_mobile_app/src/common/widgets/navigation_bar.dart';

class AnnouncementPage extends StatelessWidget {
  const AnnouncementPage({super.key});

  @override
  Widget build(BuildContext context) {
    const placeholderColor = Color(0xFFE0E0E0);

    return Scaffold(
      bottomNavigationBar: CustomNavBar(),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 16),

            // Top small centered bar
            Center(
              child: Container(
                height: 20,
                width: 150,
                decoration: BoxDecoration(
                  color: placeholderColor,
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Row with two small bars
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    height: 35,
                    decoration: BoxDecoration(
                      color: placeholderColor,
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 2,
                  child: Container(
                    height: 35,
                    decoration: BoxDecoration(
                      color: placeholderColor,
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Medium rectangle
            Container(
              height: 160,
              width: double.infinity,
              decoration: BoxDecoration(
                color: placeholderColor,
                borderRadius: BorderRadius.circular(8),
              ),
            ),

            const SizedBox(height: 20),

            // Large rectangle
            Container(
              height: 180,
              width: double.infinity,
              decoration: BoxDecoration(
                color: placeholderColor,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
