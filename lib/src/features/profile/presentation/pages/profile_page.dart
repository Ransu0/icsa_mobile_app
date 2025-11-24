import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:icsa_mobile_app/src/common/widgets/navigation_bar.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(24, 24),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // LOGO
              Image.asset(
                'images/codex-logo.png',
                height: 35,
              ),

              const SizedBox(height: 15),

              // 3D Back Button + Centered Title
              Stack(
                alignment: Alignment.center,
                children: [
                  // Center title
                  const Text(
                    "Profile",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  // 3D Back Button (left)
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF1F2533),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.5),
                            offset: const Offset(3, 3),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.of(context).maybePop();
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomNavBar(),
      backgroundColor: const Color(0xFF242C3B),
      body: Column(
        children: [
          // =====================================================
          // TOP ROUNDED HEADER
          // =====================================================

          const SizedBox(height: 20),

          // =====================================================
          // MAIN CONTENT SCROLL AREA
          // =====================================================
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // PROFILE ROW: avatar, name, edit button (aligned)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const CircleAvatar(
                        radius: 35,
                        backgroundColor: Colors.orange,
                        child:
                            Icon(Icons.person, size: 40, color: Colors.white),
                      ),

                      const SizedBox(width: 15),

                      // Make the name and button aligned horizontally and placed to the right of avatar
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Name aligned with avatar (left side)
                            const Text(
                              "John Cena",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            // 3D EDIT PROFILE BUTTON (right side of this row)
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.4),
                                    offset: const Offset(3, 3),
                                    blurRadius: 6,
                                  ),
                                ],
                              ),
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: Colors.black,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 18, vertical: 12),
                                  shadowColor: Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: const Text(
                                  "Edit Profile",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 25),

                  // PERSONAL INFO SECTION
                  _sectionTitle(Icons.person_outline, "Personal Info"),
                  _infoCard(
                    children: [
                      _infoRow("E-mail", "test_email@gmail.com"),
                      _infoRow("Gender", "Male"),
                      _infoRow("Phone Number", "+0912131415"),
                      _infoRow("Birthday", "05/13/05"),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // STUDENT INFO SECTION
                  _sectionTitle(Icons.school_outlined, "Student Info"),
                  _infoCard(
                    children: [
                      _infoRow("Program", "Information Technology"),
                      _infoRow("Student ID", "2023-00171"),
                      _infoRow("Year and Set", "3-H"),
                    ],
                  ),

                  const SizedBox(height: 30),
                  const SizedBox(height: 20),

                  // STUDENT INFO SECTION
                  _sectionTitle(Icons.badge, "Admin Info"),
                  _infoCard(
                    children: [
                      _infoRow("Program", "Information Technology"),
                      _infoRow("Student ID", "2023-00171"),
                      _infoRow("Year and Set", "3-H"),
                    ],
                  ),
                  const SizedBox(height: 20),

                  SizedBox(
                    width: 100,
                    height: 30,
                    child: IconButton(
                      onPressed: () => context.go("/admin"),
                      icon: Icon(Icons.admin_panel_settings),
                      color: Colors.white,
                      focusColor: Colors.amberAccent,
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // SECTION TITLE
  Widget _sectionTitle(IconData icon, String title) {
    return Row(
      children: [
        Icon(icon, color: Colors.white, size: 22),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }

  // CARD
  Widget _infoCard({required List<Widget> children}) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFF2E3749),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(children: children),
    );
  }

  // ROW INSIDE CARD
  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: const TextStyle(color: Colors.white70, fontSize: 14)),
          Text(value,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
