import 'package:icsa_mobile_app/src/models/auth_model.dart';
import 'package:icsa_mobile_app/src/service/auth_service.dart';

class AuthRepository {
  final AuthService _service;

  AuthRepository(this._service);

  Future<AuthUser> login(String email, String password) {
    return _service.signIn(email, password);
  }

  Future<void> logout() => _service.signOut();

  Future<AuthUser?> currentUser() => _service.getCurrentUser();
}
