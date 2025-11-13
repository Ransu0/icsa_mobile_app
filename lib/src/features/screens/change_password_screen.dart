import 'package:flutter/material.dart';
import 'package:icsa_mobile_app/src/features/home/presentation/pages/DashboardScreen.dart';
import 'package:icsa_mobile_app/src/features/screens/settings_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const ChangePasswordScreen(),
    );
  }
}

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E2432), // Dark background
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              // Back Button
             // Back Button with border
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color.fromARGB(255, 122, 108, 108), width: 1.5), // white border
                      borderRadius: BorderRadius.circular(15), // rounded corners
                    ),
                    child: IconButton(
                      onPressed: () {
                        // Navigate to DashboardScreen
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const SettingsScreen()),
                        );
                      },
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                    ),
                  ),

              const SizedBox(height: 40),
              // Logo
              Center(
                child: Image.asset(
                  'assets/logo.png', // Replace with your logo path
                  height: 80,
                ),
              ),
              const SizedBox(height: 40),
              // Title
              const Text(
                'Change password',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 30),

              // Old Password Label
              const Text(
                'Old Password',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              // Old Password Field
              const TextField(
                obscureText: true,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color(0xFF2C3348),
                  hintText: 'Enter your old password',
                    hintStyle: TextStyle(
                      color: Colors.white70,
                      ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // New Password Label
              const Text(
                'New Password',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              // New Password Field
              const TextField(
                obscureText: true,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color(0xFF2C3348),
                  hintText: 'Enter your new password',
                     hintStyle: TextStyle(
                    color: Colors.white70,
                    ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Re-enter New Password Label
              const Text(
                'Re-enter New Password',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              // Re-enter New Password Field
              const TextField(
                obscureText: true,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color(0xFF2C3348),
                  hintText: 'Re-enter your new password',
                    hintStyle: TextStyle(
                      color: Colors.white70,
                      ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // Login Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
