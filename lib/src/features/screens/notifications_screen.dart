import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Color bgColor = const Color(0xFF1E2430); // Dark background
    final Color cardColor = const Color(0xFF2B3244);
    final Color orangeAccent = const Color(0xFFFF8C00);
    final Color blueAccent = Colors.lightBlueAccent;

    return Scaffold(
      backgroundColor: bgColor,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: bgColor,
        selectedItemColor: orangeAccent,
        unselectedItemColor: Colors.white70,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.settings_outlined), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.notifications_active_outlined), label: ''),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header row
              // Header section with centered title and left back button
                      SizedBox(
                                width: double.infinity,
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF2B3244), // Same as card color
                                          borderRadius: BorderRadius.circular(16),
                                          border: Border.all(color: const Color.fromARGB(255, 86, 79, 79), width: 1), // White border
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withOpacity(0.4), // Bottom shadow
                                              offset: const Offset(0, 4),
                                              blurRadius: 6,
                                            ),
                                          ],
                                        ),
                                        child: IconButton(
                                          onPressed: () {Navigator.pushNamed(context, '/another');},
                                          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    const Center(
                                      child: Text(
                                        'Notifications',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),




              const SizedBox(height: 12),

              const Text(
                'Earlier',
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),

              const SizedBox(height: 12),

              // Notification Cards
              NotificationCard(
                icon: Icons.event,
                title: 'Upcoming Events',
                subtitle: 'Bansay 2025',
                subtitleColor: orangeAccent,
              ),
              NotificationCard(
                icon: Icons.attach_money,
                title: 'Pending Fines',
                subtitle: 'Panagtagbo 2025',
                subtitleColor: orangeAccent,
              ),
              NotificationCard(
                icon: Icons.school,
                title: 'Enrollment',
                subtitle: 'Enrollment Successful',
                subtitleColor: blueAccent,
              ),

              const Spacer(),

              const Center(
                child: Text(
                  'Wednesday, Oct 29 2025',
                  style: TextStyle(color: Colors.white54, fontSize: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NotificationCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color subtitleColor;

  const NotificationCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.subtitleColor,
  });

  @override
  Widget build(BuildContext context) {
    final Color cardColor = const Color(0xFF2B3244);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color.fromARGB(255, 117, 109, 109), width: 1), // 👈 White outline
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4), // Shadow at bottom only
            offset: const Offset(0, 4),
            blurRadius: 6,
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Icon(icon, color: Colors.white, size: 30),
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            color: subtitleColor,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: TextButton.icon(
          style: TextButton.styleFrom(
            backgroundColor: Colors.transparent, // Transparent to match card
            foregroundColor: Colors.white70,     // Text and icon color
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            minimumSize: Size.zero,              // Shrinks button to fit content
            tapTargetSize: MaterialTapTargetSize.shrinkWrap, // No extra space
          ),
          onPressed: () {
            // Navigate to another screen or leave empty for null action
            // Navigator.push(context, MaterialPageRoute(builder: (_) => AnotherScreen()));
          },
          icon: const Icon(Icons.arrow_forward_ios, size: 16),
          label: const Text('View'),
        ),

      ),
    );
  }
}

