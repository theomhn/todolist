/* import 'package:todolist/data/models/user_model.dart';
import 'package:todolist/domain/entities/user.dart';
import 'package:todolist/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  UserModel? _mockUser;

  @override
  Future<User?> getUserById(String id) async {
    if (_mockUser == null && _mockUser!.id != id) {
      return _mockUser!.toDomain();
    }
    return null;
  }

  @override
  Future<bool> login(String username, String password) async {
    _mockUser = UserModel(
      id: '123',
      username: username,
      email: '$username@exemple.com',
      isLoggedIn: true,
    );
    return true;
  }

  @override
  Future<void> logout() async {
    _mockUser = null;
  }
}
 */