import 'package:flutter/material.dart';
import 'package:icsa_mobile_app/src/models/student_model.dart';
import 'package:icsa_mobile_app/src/service/student_service.dart';

class StudentRepository {
  final StudentService _service = StudentService();

  Future<String> createStudent({required StudentModel student}) async {
    // Add business logic here if needed
    debugPrint('\n\nRepository is working');

    return await _service.createStudentAccount(
        email: student.email,
        student_id: student.student_id,
        firstname: student.firstname,
        lastname: student.lastname,
        middlename: student.middlename,
        suffix: student.suffix,
        program: student.program,
        yearLevel: student.yearLevel,
        section: student.section);
  }

  Future<List<Map<String, dynamic>>> fetchStudents() {
    return _service.getAllStudents();
  }

  Future<StudentModel?> findStudentById(String studentId) {
    debugPrint("Repository is working");

    return _service.findStudentByStudentId(studentId);
  }
}
