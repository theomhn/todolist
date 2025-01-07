import 'package:todolist/domain/entities/user.dart';

abstract class UserRepository {
  Future<User?> getUserById(String id);
  Future<bool> login(String username, String password);
  Future<void> logout();
}
