import 'package:flutter/material.dart';
import 'package:todolist/domain/entities/user_app.dart';
import 'package:todolist/domain/usecases/user.dart';

class AuthProvider extends ChangeNotifier {
  final SignInWithEmail _signInWithEmail;
  UserApp? _user;

  AuthProvider(this._signInWithEmail);

  UserApp? get user => _user;

  Future<void> signIn(String email, String password) async {
    try {
      _user = await _signInWithEmail(email, password);
      notifyListeners();
    } catch (e) {
      print('Error during sign in: $e');
      _user = null;
      notifyListeners();
    }
  }

  void signOut() {
    _user = null;
    notifyListeners();
  }
}
