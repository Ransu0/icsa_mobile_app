import 'package:flutter/material.dart';
import 'package:icsa_mobile_app/src/models/auth_model.dart';
import 'package:icsa_mobile_app/src/repository/auth_repository.dart';

class AuthProvider extends ChangeNotifier {
  final AuthRepository _repo;

  AuthProvider(this._repo);

  AuthUser? user;
  bool isLoading = false;
  String? errorMessage;

  Future<void> login(String email, String password) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      user = await _repo.login(email, password);
    } catch (e) {
      errorMessage = e.toString();
      user = null;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    await _repo.logout();
    user = null;
    notifyListeners();
  }

  /// To auto-login using FirebaseAuth persistence
  Future<void> loadCurrentUser() async {
    user = await _repo.currentUser();
    notifyListeners();
  }
}
