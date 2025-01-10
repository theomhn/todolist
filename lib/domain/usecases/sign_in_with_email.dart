import 'package:todolist/domain/entities/user_app.dart';
import 'package:todolist/domain/repositories/auth_repository.dart';

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
