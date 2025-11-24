import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:icsa_mobile_app/src/models/student_model.dart';

class StudentService {
  final _functions = FirebaseFunctions.instance;
  final _firestore = FirebaseFirestore.instance;

  Future<String> createStudentAccount({
    required String email,
    required String firstname,
    required String lastname,
    String suffix = "",
    String middlename = "",
    required String student_id,
    required String program,
    required String section,
    required int yearLevel,
  }) async {
    final callable = _functions.httpsCallable("createStudentAccount");

    debugPrint('\n\nService is working');

    final response = await callable.call({
      "email": email,
      "firstname": firstname,
      "lastname": lastname,
      "middlename": middlename,
      "suffix": suffix,
      "student_id": student_id,
      "program": program,
      "section": section,
      "yearLevel": yearLevel,
    });
    debugPrint('\n\nResponse: $response');

    return response.data["uid"];
  }

  Future<List<Map<String, dynamic>>> getAllStudents() async {
    final callable = _functions.httpsCallable("listStudents");
    final response = await callable.call();

    List students = response.data["students"];
    return List<Map<String, dynamic>>.from(students);
  }

  Future<StudentModel?> findStudentByStudentId(String studentId) async {
    debugPrint("Service is working");

    final query = await _firestore
        .collection("students")
        .where("student_id", isEqualTo: studentId)
        .limit(1)
        .get();

    if (query.docs.isEmpty) return null;
    debugPrint("working query");

    final doc = query.docs.first;

    return StudentModel.fromJson(doc.data(), doc.id);
  }
}
