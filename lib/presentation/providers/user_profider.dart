import 'package:flutter/material.dart';
import 'package:todolist/domain/usecases/user.dart';
import 'package:todolist/domain/entities/user.dart';

class UserProvider extends ChangeNotifier {
  final GetUser getUser;
  final LoginUser loginUser;
  final LogoutUser logoutUser;

  User? _currentUser;
  User? get currentUser => _currentUser;

  UserProvider(
      {required this.getUser,
      required this.loginUser,
      required this.logoutUser});

  Future<void> fetchUser(String id) async {
    _currentUser = await getUser(id);
    notifyListeners();
  }

  Future<void> login(String username, String password) async {
    final success = await loginUser(username, password);
    if (success) {
      _currentUser = User(
          id: '123',
          username: username,
          email: '$username@exemple.com',
          isLoggedIn: true);
      notifyListeners();
    }
  }

  Future<void> logout() async {
    await logoutUser();
    _currentUser = null;
    notifyListeners();
  }
}
