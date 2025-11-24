import 'package:cloud_firestore/cloud_firestore.dart';

class StudentModel {
  final String uid;
  final String firstname;
  final String lastname;
  final String middlename;
  final String suffix;
  final String student_id;
  final String section;
  final String email;
  final String program;
  final int yearLevel;
  final DateTime createdAt;
  final String role;

  StudentModel({
    this.uid = "",
    required this.firstname,
    required this.lastname,
    this.middlename = "",
    this.suffix = "",
    required this.student_id,
    required this.email,
    required this.program,
    required this.yearLevel,
    required this.section,
    required this.createdAt,
    this.role = "user",
  });

  factory StudentModel.fromJson(Map<String, dynamic> json, String uid) {
    return StudentModel(
      uid: uid,
      firstname: json['firstname'] ?? "",
      lastname: json['lastname'] ?? "",
      middlename: json['middlename'] ?? "",
      suffix: json['suffix'] ?? "",
      email: json['email'] ?? "",
      student_id: json['student_id'] ?? "",
      section: json['section'] ?? "", // FIX: previously "set"
      program: json['program'] ?? "",
      yearLevel: json['yearLevel'] ?? 1,
      role: json['role'] ?? "user",
      // Safe timestamp conversion
      createdAt: json['createdAt'] is Timestamp
          ? (json['createdAt'] as Timestamp).toDate()
          : DateTime.now(), // fallback
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "uid": uid,
      "firstname": firstname,
      "lastname": lastname,
      "middlename": middlename,
      "suffix": suffix,
      "student_id": student_id,
      "email": email,
      "program": program,
      "section": section,
      "yearLevel": yearLevel,
      "createdAt": createdAt,
    };
  }
}
