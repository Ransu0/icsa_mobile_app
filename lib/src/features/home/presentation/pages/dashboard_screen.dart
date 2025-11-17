import 'package:flutter/material.dart';
import 'package:icsa_mobile_app/src/common/widgets/navigation_bar.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const darkBackground = Color.fromARGB(255, 58, 58, 75);
    const orangeColor = Color(0xFFFF8C42);
    const cardBackground = Color.fromARGB(255, 58, 58, 75);
    const whiteColor = Colors.white;

    return Scaffold(
      backgroundColor: darkBackground,
      bottomNavigationBar: CustomNavBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- Greeting Card ---
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: cardBackground,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                      color: const Color.fromARGB(255, 113, 103, 103),
                      width: 1.5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.4),
                      blurRadius: 6,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: const Color.fromARGB(255, 237, 217, 217),
                            width: 2),
                        image: const DecorationImage(
                          image: AssetImage('assets/events/avatar.jpeg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      'Hi, First Name! 👋',
                      style: TextStyle(
                        color: whiteColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // --- Dashboard Card ---
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: orangeColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Dashboard',
                      style: TextStyle(
                        color: whiteColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Track your clearance, enrollment, and payments.',
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // --- Mini Cards ---
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    SizedBox(
                      width:
                          (MediaQuery.of(context).size.width - 16 * 2 - 12) / 2,
                      child: DashboardMiniCard(
                        icon: Icons.check_circle,
                        title: 'Clearance',
                        subtitle: 'Cleared',
                        cardColor: cardBackground,
                        iconColor: whiteColor,
                        subtitleColor: Colors.lightGreenAccent,
                      ),
                    ),
                    SizedBox(
                      width:
                          (MediaQuery.of(context).size.width - 16 * 2 - 12) / 2,
                      child: DashboardMiniCard(
                        icon: Icons.school,
                        title: 'Enrollment',
                        subtitle: 'Ongoing',
                        cardColor: cardBackground,
                        iconColor: whiteColor,
                        subtitleColor: Colors.blueAccent,
                      ),
                    ),
                    SizedBox(
                      width:
                          (MediaQuery.of(context).size.width - 16 * 2 - 12) / 2,
                      child: DashboardMiniCard(
                        icon: Icons.attach_money,
                        title: 'Payments & Fines',
                        subtitle: '2 Pending',
                        cardColor: cardBackground,
                        iconColor: whiteColor,
                        subtitleColor: Colors.redAccent,
                      ),
                    ),
                    SizedBox(
                      width:
                          (MediaQuery.of(context).size.width - 16 * 2 - 12) / 2,
                      child: DashboardMiniCard(
                        icon: Icons.event,
                        title: 'Events',
                        subtitle: '3 Upcoming',
                        cardColor: cardBackground,
                        iconColor: whiteColor,
                        subtitleColor: Colors.cyanAccent,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // --- Announcements ---
              const Text(
                'Announcements & Updates',
                style: TextStyle(
                  color: whiteColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const AnnouncementsCard(imagePath: 'assets/events/image.png'),
              const SizedBox(height: 14),

              const Text(
                'SGA & Resolutions',
                style: TextStyle(
                  color: whiteColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const AnnouncementsCard(imagePath: 'assets/events/image1.png'),
              const SizedBox(height: 14),

              const Center(
                child: Text(
                  'Wednesday, Oct 29 2025',
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// --- Mini Card Widget ---
class DashboardMiniCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color cardColor;
  final Color iconColor;
  final Color subtitleColor;

  const DashboardMiniCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.cardColor,
    required this.iconColor,
    required this.subtitleColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
            color: const Color.fromARGB(255, 113, 103, 103), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 6,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: iconColor, size: 28),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(color: subtitleColor, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

// --- Announcements Card Widget ---
class AnnouncementsCard extends StatelessWidget {
  final String imagePath;

  const AnnouncementsCard({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 6,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.asset(
          imagePath,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              height: 200,
              color: Colors.grey,
              child: Center(
                child: Text(
                  'Image not found: $imagePath',
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
