import 'package:firebase_auth/firebase_auth.dart' show User;
import 'package:todolist/data/datasources/firebase_auth_service.dart';
import 'package:todolist/data/models/user_model.dart';
import 'package:todolist/domain/mappers/firebase_to_user_model_mapper.dart';
import 'package:todolist/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuthService authService;
  final FirebaseToUserModelMapper firebaseToUserModelMapper;

  AuthRepositoryImpl(this.authService, this.firebaseToUserModelMapper);

  @override
  Future<UserModel?> signInWithEmailPassword(
      String email, String password) async {
    final User? firebaseUser =
        await authService.signInWithEmailPassword(email, password);

    if (firebaseUser != null) {
      return firebaseToUserModelMapper.map(firebaseUser);
    }
    return null;
  }

  @override
  Future<UserModel?> getUserById(String id) async {
    final User? firebaseUser = await authService.getUserById(id);

    if (firebaseUser != null) {
      return firebaseToUserModelMapper.map(firebaseUser);
    }
    return null;
  }

  @override
  Future<void> logout() async {
    await authService.signOut();
  }
}
