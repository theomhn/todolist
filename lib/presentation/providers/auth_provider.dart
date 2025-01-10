import 'package:flutter/material.dart';
import 'package:todolist/domain/entities/user_app.dart';
import 'package:todolist/domain/usecases/sign_in_with_email.dart';

class AuthProvider with ChangeNotifier {
  final SignInWithEmail signInWithEmail;

  AuthProvider(this.signInWithEmail);

  UserApp? _user;
  UserApp? get user => _user;

  Future<void> signIn(String email, String password) async {
    _user = await signInWithEmail(email, password);
    notifyListeners();
  }
}
