import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:icsa_mobile_app/src/core/theme/app_spacing.dart';
import 'package:icsa_mobile_app/src/core/theme/app_text_styles.dart';
import 'package:icsa_mobile_app/src/core/widgets/custom_button.dart';
import 'package:icsa_mobile_app/src/provider/auth_provider.dart';
import 'package:icsa_mobile_app/src/provider/student_provider.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _studentIdController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    _studentIdController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLoginPressed() async {
    if (!mounted) {
      debugPrint("Component not yet mounted");
      return;
    }

    final auth = await context.read<AuthProvider>();
    final student = await context
        .read<StudentProvider>()
        .findStudentById(_studentIdController.text);

    if (student != null) {
      debugPrint("Student found: ${student.firstname}");
    } else {
      debugPrint("Student not found!");
      return;
    }

    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    await auth.login(student.email, _passwordController.text);

    if (auth.errorMessage != null) {
      debugPrint("Login failed: ${auth.errorMessage}");
      return;
    } else {
      debugPrint("Logged in as: ${auth.user!.email}");
      debugPrint("Role: ${auth.user!.role}");

      if (mounted) context.go('/home');
    }

    setState(() => _isLoading = false);

    // Example navigation
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Theme.of(context).colorScheme.onSurface, // Dark background
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo
                Image.asset(
                  '/images/codex-logo.png',
                  height: 80,
                ),
                const SizedBox(height: AppSpacing.xl),

                // Login Header
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Login',
                    style: AppTextStyles.heading1.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),

                // Login Form
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // Student ID
                      TextFormField(
                        controller: _studentIdController,
                        decoration: InputDecoration(
                          labelText: 'Student ID',
                          hintText: 'Enter your Student ID',
                          hintStyle: AppTextStyles.body.copyWith(
                            color: Colors.grey.shade500,
                          ),
                          labelStyle: AppTextStyles.body.copyWith(
                            color: Colors.white70,
                          ),
                          filled: true,
                          fillColor: const Color(0xFF1F2937),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(AppSpacing.borderRadius),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        style: AppTextStyles.body.copyWith(color: Colors.white),
                        validator: (value) => value == null || value.isEmpty
                            ? 'Please enter your Student ID'
                            : null,
                      ),
                      const SizedBox(height: AppSpacing.md),

                      // Password
                      TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          hintText: 'Enter your password',
                          hintStyle: AppTextStyles.body.copyWith(
                            color: Colors.grey.shade500,
                          ),
                          labelStyle: AppTextStyles.body.copyWith(
                            color: Colors.white70,
                          ),
                          filled: true,
                          fillColor: const Color(0xFF1F2937),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(AppSpacing.borderRadius),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        style: AppTextStyles.body.copyWith(color: Colors.white),
                        validator: (value) => value == null || value.isEmpty
                            ? 'Please enter your password'
                            : null,
                      ),

                      const SizedBox(height: AppSpacing.sm),

                      // Forgot Password
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            // TODO: Forgot password screen
                          },
                          child: const Text(
                            'forgot password?',
                            style: TextStyle(color: Colors.white70),
                          ),
                        ),
                      ),

                      const SizedBox(height: AppSpacing.lg),

                      // Login Button
                      _isLoading
                          ? CircularProgressIndicator(
                              color: Theme.of(context).colorScheme.tertiary)
                          : CustomButton(
                              label: 'Login',
                              onPressed: _onLoginPressed,
                              isPrimary: true,
                            ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                ElevatedButton(
                  onPressed: () => {context.go("/register")},
                  child: Text("Register Admin"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
