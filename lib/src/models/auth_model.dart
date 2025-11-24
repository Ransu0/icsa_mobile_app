import 'package:firebase_auth/firebase_auth.dart';

class AuthUser {
  final String uid;
  final String email;
  final String? role;

  AuthUser({
    required this.uid,
    required this.email,
    this.role,
  });

  factory AuthUser.fromFirebase(User user, Map<String, dynamic>? claims) {
    return AuthUser(
      uid: user.uid,
      email: user.email ?? "",
      role: claims?["role"],
    );
  }
}
