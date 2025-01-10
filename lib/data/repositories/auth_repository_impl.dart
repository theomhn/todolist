import 'package:todolist/data/models/user_model.dart';
import 'package:todolist/domain/entities/user.dart';
import 'package:todolist/domain/repositories/auth_repository.dart';

import '../datasources/firebase_auth_service.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuthService authService;
  final FirebaseToUserModelMapper firebaseToUserModelMapper;

  AuthRepositoryImpl(this.authService, this.firebaseToModelMapper);

  @override
  Future<UserModel?> signInWithEmailPassword(
      String email, String password) async {
    User? firebaseUser =
        (await authService.signInWithEmailPassword(email, password)) as User?;

    if (firebaseUser != null) {
      return firebaseToModelMapper.map(firebaseUser);
    }
    return null;
  }
}