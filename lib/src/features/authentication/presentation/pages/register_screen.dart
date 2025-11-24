import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:icsa_mobile_app/src/models/student_model.dart';
import 'package:icsa_mobile_app/src/provider/student_provider.dart';
import 'package:provider/provider.dart';

class RegisterAdminPage extends StatefulWidget {
  const RegisterAdminPage({super.key});

  @override
  State<RegisterAdminPage> createState() => _RegisterAdminPageState();
}

class _RegisterAdminPageState extends State<RegisterAdminPage> {
  final _formKey = GlobalKey<FormState>();

  // Text controllers
  final _emailController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _middleNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _suffixController = TextEditingController();
  final _studentIdController = TextEditingController();

  // Dropdown values
  String? _selectedProgram;
  String? _selectedSet;
  int? _selectedYearLevel;

  void _handleFormSubmit() async {
    if (_formKey.currentState?.validate() != true) return;

    // Access form values here
    final data = {
      "email": _emailController.text.trim(),
      'firstname': _firstNameController.text.trim(),
      'middlename': _middleNameController.text.trim(),
      'lastname': _lastNameController.text.trim(),
      'suffix': _suffixController.text.trim(),
      'student_id': _studentIdController.text.trim(),
      'program': _selectedProgram,
      'section': _selectedSet,
      'yearLevel': _selectedYearLevel,
    };

    debugPrint('\n\nStudent form submitted: $data');
    await context
        .read<StudentProvider>()
        .createStudent(student: StudentModel.fromJson(data, ""));

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Student saved successfully')),
      );
    }
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _middleNameController.dispose();
    _lastNameController.dispose();
    _suffixController.dispose();
    _studentIdController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF16151C), // your login bg
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // LOGO
              Center(
                child: Image.asset(
                  '/images/codex-logo.png',
                  height: 90,
                ),
              ),

              const SizedBox(height: 30),

              const Text(
                "Register Admin",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 25),

              Form(
                key: _formKey,
                child: Column(
                  children: [
                    _inputField("Email", _emailController),
                    const SizedBox(height: 14),
                    _inputField("Student ID", _studentIdController),
                    const SizedBox(height: 14),
                    _inputField("First Name", _firstNameController),
                    const SizedBox(height: 14),
                    _inputField(
                        "Middle Name (optional)", _middleNameController),
                    const SizedBox(height: 14),
                    _inputField("Last Name", _lastNameController),
                    const SizedBox(height: 14),
                    _inputField("Suffix (optional)", _suffixController),

                    const SizedBox(height: 20),

                    // Program dropdown
                    DropdownButtonFormField<String>(
                      initialValue: _selectedProgram,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      dropdownColor: const Color(0xFF1F2330),
                      icon: const Icon(Icons.arrow_drop_down,
                          color: Color.fromRGBO(255, 255, 255, 0.702)),
                      items: const [
                        DropdownMenuItem(
                          value: 'BSIT',
                          child: Text('BSIT - Information Technology'),
                        ),
                        DropdownMenuItem(
                          value: 'BSIS',
                          child: Text('BSIS - Information Systems'),
                        ),
                      ],
                      onChanged: (value) => setState(() {
                        _selectedProgram = value;
                      }),
                      validator: (value) =>
                          value == null ? 'Please select a program' : null,
                    ),
                    const SizedBox(height: 14),

                    // Set dropdown
                    DropdownButtonFormField<String>(
                      initialValue: _selectedSet,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      dropdownColor: const Color(0xFF1F2330),
                      icon: const Icon(Icons.arrow_drop_down,
                          color: Colors.white70),
                      items: ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H']
                          .map(
                            (s) => DropdownMenuItem(
                              value: s,
                              child: Text('Set $s'),
                            ),
                          )
                          .toList(),
                      onChanged: (value) => setState(() {
                        _selectedSet = value;
                      }),
                      validator: (value) =>
                          value == null ? 'Please select a set' : null,
                    ),
                    const SizedBox(height: 14),

                    // Year Level dropdown
                    DropdownButtonFormField<int>(
                      initialValue: _selectedYearLevel,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      dropdownColor: const Color(0xFF1F2330),
                      icon: const Icon(Icons.arrow_drop_down,
                          color: Colors.white70),
                      items: [1, 2, 3, 4]
                          .map(
                            (y) => DropdownMenuItem(
                              value: y,
                              child: Text('$y${_suffixYear(y)} Year'),
                            ),
                          )
                          .toList(),
                      onChanged: (value) => setState(() {
                        _selectedYearLevel = value;
                      }),
                      validator: (value) =>
                          value == null ? 'Please select year level' : null,
                    ),

                    const SizedBox(height: 30),

                    // REGISTER BUTTON
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _handleFormSubmit();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF7B61FF),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          "Register Admin",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // BACK TO LOGIN
                    Center(
                      child: TextButton(
                        onPressed: () => context.go("/login"),
                        child: const Text(
                          "Back to Login",
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _inputField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(color: Colors.white, fontSize: 14),
        ),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFF1F2330),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
          ),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              if (label.contains("(optional)")) return null;
              return "This field is required";
            }
            return null;
          },
        ),
      ],
    );
  }

  String _suffixYear(int year) {
    switch (year) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }
}
