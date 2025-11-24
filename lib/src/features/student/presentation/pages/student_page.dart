import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:icsa_mobile_app/src/common/widgets/navigation_bar.dart';
import 'package:icsa_mobile_app/src/models/student_model.dart';
import 'package:icsa_mobile_app/src/provider/student_provider.dart';
import 'package:icsa_mobile_app/src/provider/auth_provider.dart' as auth;

import 'package:provider/provider.dart';

class StudentPage extends StatefulWidget {
  const StudentPage({super.key});

  @override
  State<StatefulWidget> createState() => _StudentPageState();
}

class _StudentPageState extends State<StudentPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(() {
      if (mounted) {
        context.read<StudentProvider>().loadStudents();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final students = context.watch<StudentProvider>();
    final colorScheme = Theme.of(context).colorScheme;
    final studentList = students.students;

    debugPrint('Role: ${context.read<auth.AuthProvider>().user?.role}');

    if (students.students.isEmpty) {
      debugPrint("List is empty");
    }
    for (var element in studentList) {
      debugPrint(element.email);
    }
    if (students.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        title: const Text('Manage Students'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'Add Student',
            onPressed: () => context.go("/admin/students/add-student"),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: students.students.isEmpty
            ? const Center(child: Text('No students found'))
            : SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: const [
                    DataColumn(label: Text('Student ID')),
                    DataColumn(label: Text('First Name')),
                    DataColumn(label: Text('Last Name')),
                    DataColumn(label: Text('Program')),
                    DataColumn(label: Text('Section')),
                    DataColumn(label: Text('Year Level')),
                    DataColumn(label: Text('Actions')),
                  ],
                  rows: studentList
                      .map(
                        (s) => DataRow(cells: [
                          DataCell(Text(s.student_id)),
                          DataCell(Text(s.firstname)),
                          DataCell(Text(s.lastname)),
                          DataCell(Text(s.program)),
                          DataCell(Text(s.section)),
                          DataCell(Text('${s.yearLevel}')),
                          DataCell(Row(
                            children: [
                              IconButton(
                                icon:
                                    const Icon(Icons.delete, color: Colors.red),
                                onPressed: () => context
                                    .read<StudentProvider>()
                                    .deleteStudent(s.uid),
                              ),
                              IconButton(
                                  onPressed: () =>
                                      context.read<StudentProvider>(),
                                  icon: const Icon(Icons.edit))
                            ],
                          )),
                        ]),
                      )
                      .toList(),
                ),
              ),
      ),
      bottomNavigationBar: const CustomNavBar(),
    );
  }
}
