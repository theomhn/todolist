import 'package:firebase_auth/firebase_auth.dart' show User;
import 'package:todolist/data/models/user_model.dart';

class FirebaseToUserModelMapper {
  UserModel map(User firebaseUser) {
    return UserModel(
      id: firebaseUser.uid,
      email: firebaseUser.email ?? '',
      name: firebaseUser.displayName ?? 'User',
    );
  }
}
