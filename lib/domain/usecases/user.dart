import 'package:todolist/domain/entities/user_app.dart';
import 'package:todolist/domain/mappers/user_model_to_user_mapper.dart';
import 'package:todolist/domain/repositories/auth_repository.dart';

class GetUser {
  final AuthRepository repository;
  final UserModelToUserMapper userModelToUserMapper;

  GetUser(this.repository, this.userModelToUserMapper);

  Future<UserApp?> call(String id) async {
    final userModel = await repository.getUserById(id);
    if (userModel != null) {
      return userModelToUserMapper.map(userModel);
    }
    return null;
  }
}

class SignInWithEmail {
  final AuthRepository authRepository;
  final UserModelToUserMapper userModelToUserMapper;

  SignInWithEmail(this.authRepository, this.userModelToUserMapper);

  Future<UserApp?> call(String email, String password) async {
    final userModel =
        await authRepository.signInWithEmailPassword(email, password);
    if (userModel != null) {
      return userModelToUserMapper.map(userModel);
    }
    return null;
  }
}

class LogoutUser {
  final AuthRepository repository;

  LogoutUser(this.repository);

  Future<void> call() => repository.logout();
}
