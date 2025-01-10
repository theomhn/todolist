import 'package:todolist/domain/entities/user.dart';
import 'package:todolist/domain/repositories/user_repository.dart';

class GetUser {
  final UserRepository repository;
  GetUser(this.repository);
  Future<User?> call(String id) => repository.getUserById(id);
}

class LoginUser {
  final UserRepository repository;
  LoginUser(this.repository);

  Future<bool> call(String username, String password) =>
      repository.login(username, password);
}

class LogoutUser {
  final UserRepository repository;
  LogoutUser(this.repository);
  Future<void> call() => repository.logout();
}


