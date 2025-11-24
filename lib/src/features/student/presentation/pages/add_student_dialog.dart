import 'package:flutter/material.dart';
import 'package:icsa_mobile_app/src/models/student_model.dart';
import 'package:icsa_mobile_app/src/provider/student_provider.dart';
import 'package:provider/provider.dart';

class StudentFormPage extends StatefulWidget {
  const StudentFormPage({super.key});

  @override
  State<StudentFormPage> createState() => _StudentFormPageState();
}

class _StudentFormPageState extends State<StudentFormPage> {
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

  void _submitForm() async {
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Student'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // Email
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                      (value == null || value.isEmpty) ? 'Required' : null,
                ),
                const SizedBox(
                  height: 12,
                ),
                // First Name
                TextFormField(
                  controller: _firstNameController,
                  decoration: const InputDecoration(
                    labelText: 'First Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                      (value == null || value.isEmpty) ? 'Required' : null,
                ),
                const SizedBox(height: 12),

                // Middle Name
                TextFormField(
                  controller: _middleNameController,
                  decoration: const InputDecoration(
                    labelText: 'Middle Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),

                // Last Name
                TextFormField(
                  controller: _lastNameController,
                  decoration: const InputDecoration(
                    labelText: 'Last Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                      (value == null || value.isEmpty) ? 'Required' : null,
                ),
                const SizedBox(height: 12),

                // Suffix
                TextFormField(
                  controller: _suffixController,
                  decoration: const InputDecoration(
                    labelText: 'Suffix (optional)',
                    hintText: 'Jr., Sr., II, III, etc.',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),

                // Student ID
                TextFormField(
                  controller: _studentIdController,
                  decoration: const InputDecoration(
                    labelText: 'Student ID',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                      (value == null || value.isEmpty) ? 'Required' : null,
                ),
                const SizedBox(height: 16),

                // Program dropdown
                DropdownButtonFormField<String>(
                  initialValue: _selectedProgram,
                  decoration: const InputDecoration(
                    labelText: 'Program',
                    border: OutlineInputBorder(),
                  ),
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
                const SizedBox(height: 12),

                // Set dropdown
                DropdownButtonFormField<String>(
                  initialValue: _selectedSet,
                  decoration: const InputDecoration(
                    labelText: 'Set',
                    border: OutlineInputBorder(),
                  ),
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
                const SizedBox(height: 12),

                // Year Level dropdown
                DropdownButtonFormField<int>(
                  initialValue: _selectedYearLevel,
                  decoration: const InputDecoration(
                    labelText: 'Year Level',
                    border: OutlineInputBorder(),
                  ),
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

                const SizedBox(height: 24),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _submitForm,
                    child: const Text('Save Student'),
                  ),
                ),
                const SizedBox(
                  height: 30,
                )
              ],
            ),
          ),
        ),
      ),
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
