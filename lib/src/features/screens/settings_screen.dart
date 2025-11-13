import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:icsa_mobile_app/src/features/home/presentation/pages/DashboardScreen.dart';
import 'package:icsa_mobile_app/src/features/screens/change_password_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SettingsScreen(),
    );
  }
}

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isDarkMode = false;
  String? selectedIssue;
  final TextEditingController issueController = TextEditingController();
  XFile? pickedImage;

  final List<String> issues = [
    "Performance Issues",
    "Late Updates",
    "Other",
  ];

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        pickedImage = image;
      });
    }
  }

  @override
  void dispose() {
    issueController.dispose();
    super.dispose();
  }

  Widget buildDivider() {
    return const Divider(color: Colors.white24, height: 1);
  }

  Widget buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: const TextStyle(
            color: Colors.white70, fontSize: 14, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget buildRadioOptionRight(String option) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              selectedIssue = option;
            });
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  option,
                  style: const TextStyle(color: Colors.white),
                ),
                Radio<String>(
                  value: option,
                  groupValue: selectedIssue,
                  onChanged: (value) {
                    setState(() {
                      selectedIssue = value;
                    });
                  },
                  activeColor: Colors.orange,
                ),
              ],
            ),
          ),
        ),
        buildDivider(),
      ],
    );
  }

  int _currentIndex = 1; // Settings tab

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 58, 58, 75),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 58, 58, 75),
        elevation: 0,
        leading: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            border: Border.all(color: const Color.fromARGB(255, 132, 117, 117)),
            borderRadius: BorderRadius.circular(10),
          ),
          child: IconButton(
            icon: const Icon(Icons.arrow_back,
                color: Color.fromARGB(255, 239, 239, 239)),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const DashboardScreen()),
              );
            },
          ),
        ),
        title: const Text(
          "Settings",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color.fromARGB(255, 58, 58, 75),
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.white70,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: _currentIndex,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const DashboardScreen()),
            );
          }
          // Other tabs (notifications, user) can be added here
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: ''),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings_outlined), label: ''),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications_active_outlined), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: ''),
        ],
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              const Text("Display",
                  style: TextStyle(color: Colors.white, fontSize: 16)),
              const SizedBox(height: 8),
              Switch(
                value: isDarkMode,
                onChanged: (value) {
                  setState(() {
                    isDarkMode = value;
                  });
                },
                activeColor: Colors.orange,
              ),
              const SizedBox(height: 30),
              buildSectionTitle("Profile Settings"),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(0, 42, 52, 66),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Change Password",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                   GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ChangePasswordScreen(),
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: const Color.fromARGB(255, 110, 99, 99)),
                              borderRadius: BorderRadius.circular(9),
                            ),
                            child: const Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        ),

                  ],
                ),
              ),
              const SizedBox(height: 30),
              buildSectionTitle("Report a Problem"),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Column(
                  children:
                      issues.map((issue) => buildRadioOptionRight(issue)).toList(),
                ),
              ),
              if (selectedIssue == "Other") ...[
                const SizedBox(height: 12),
                TextField(
                  controller: issueController,
                  maxLines: 3,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: "Please describe the issue",
                    hintStyle:
                        const TextStyle(color: Colors.white54, fontSize: 14),
                    filled: true,
                    fillColor: const Color(0xFF2A3442),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.white24),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: pickImage,
                  child: Container(
                    height: 120,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xFF2A3442),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.white24),
                    ),
                    child: pickedImage == null
                        ? const Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.image_outlined,
                                    color: Colors.white54, size: 40),
                                SizedBox(height: 8),
                                Text(
                                  "Add or Drop photo (optional)",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white54, fontSize: 12),
                                ),
                              ],
                            ),
                          )
                        : kIsWeb
                            ? Image.network(
                                pickedImage!.path,
                                fit: BoxFit.cover,
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.file(
                                  File(pickedImage!.path),
                                  fit: BoxFit.cover,
                                ),
                              ),
                  ),
                ),
              ],
              const SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 14),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () {},
                  child: const Text("Submit",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 40),
              const Center(
                child: Text(
                  "Updated Version 2.0.1",
                  style: TextStyle(color: Colors.white54, fontSize: 12),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
