import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:icsa_mobile_app/src/core/theme/app_color.dart';
import 'package:icsa_mobile_app/src/core/theme/app_spacing.dart';
import 'package:icsa_mobile_app/src/core/theme/app_text_styles.dart';
import 'package:icsa_mobile_app/src/core/widgets/custom_button.dart';

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
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    // TODO: Add Firebase Auth logic here
    await Future.delayed(const Duration(seconds: 1));

    setState(() => _isLoading = false);

    // Example navigation
    if (mounted) {
      context.go('/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.textPrimary, // Dark background
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
                    style: AppTextStyles.headline1.copyWith(
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
                          ? const CircularProgressIndicator(
                              color: AppColors.secondary)
                          : CustomButton(
                              label: 'Login',
                              onPressed: _onLoginPressed,
                              isPrimary: true,
                            ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
