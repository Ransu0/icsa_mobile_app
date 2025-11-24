import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/rendering.dart';
import 'package:icsa_mobile_app/src/models/auth_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Sign in with email & password
  Future<AuthUser> signIn(String email, String password) async {
    final credential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    // Force refresh to get latest custom claims
    final token = await credential.user!.getIdTokenResult(true);
    // 3. Read claims
    final claims = token.claims;
    final role = claims?['role'];

    debugPrint("User logged in as: $role");

    return AuthUser.fromFirebase(
      credential.user!,
      token.claims,
    );
  }

  /// Sign out
  Future<void> signOut() async {
    await _auth.signOut();
  }

  /// Current logged-in user with claims
  Future<AuthUser?> getCurrentUser() async {
    final user = _auth.currentUser;
    if (user == null) return null;

    final idTokenResult = await user.getIdTokenResult(true);
    return AuthUser.fromFirebase(
      user,
      idTokenResult.claims,
    );
  }

  Stream<User?> authStateChanges() => _auth.authStateChanges();
}
