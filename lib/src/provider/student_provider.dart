import 'package:flutter/material.dart';
import 'package:icsa_mobile_app/src/models/student_model.dart';
import 'package:icsa_mobile_app/src/repository/student_repository.dart';

class StudentProvider extends ChangeNotifier {
  final StudentRepository _repo = StudentRepository();

  List<StudentModel> students = [];
  StudentModel? foundStudent;

  bool isLoading = false;

  Future<String?> createStudent({required StudentModel student}) async {
    isLoading = true;
    notifyListeners();

    try {
      debugPrint('\n\nProvider is working');
      final uid = await _repo.createStudent(student: student);
      return uid;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadStudents() async {
    isLoading = true;
    notifyListeners();

    var list = await _repo.fetchStudents();
    students = [];
    for (var student in list) {
      students.add(StudentModel.fromJson(student, student["uid"]));
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> deleteStudent(String uid) async {}
  Future<void> updateStudent(StudentModel student, String uid) async {}

  Future<StudentModel?> findStudentById(String studentId) async {
    isLoading = true;
    notifyListeners();
    debugPrint("Provider working");
    foundStudent = await _repo.findStudentById(studentId);

    isLoading = false;
    notifyListeners();

    return foundStudent;
  }
}
