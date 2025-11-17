import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? _user;

  User? get user => _user;
  bool get isLoggedIn => _user != null;

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  AuthProvider() {
    _auth.useAuthEmulator('localhost', 9099); // Emulator only

    _auth.authStateChanges().listen((firebaseUser) {
      _user = firebaseUser;
      notifyListeners();
    });
  }

  Future<void> signIn(String email, String password) async {
    _isLoading = false;
    notifyListeners();

    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException {
      // Example: invalid email, wrong password
      rethrow; // or handle using a custom error message
    } catch (e) {
      throw Exception('Something went wrong: $e');
    }
  }

  Future<void> register(String email, String password, String name) async {
    try {
      UserCredential cred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Optional: Save additional user info to Firestore
      // await FirebaseFirestore.instance.collection('users').doc(cred.user!.uid).set({
      //   'name': name,
      //   'email': email,
      //   'role': 'member',
      // });
    } on FirebaseAuthException {
      rethrow;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
