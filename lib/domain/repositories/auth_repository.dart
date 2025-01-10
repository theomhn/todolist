import 'package:todolist/data/models/user_model.dart';

abstract class AuthRepository {
  Future<UserModel?> signInWithEmailPassword(String email, String password);
}
