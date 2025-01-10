import 'package:todolist/data/models/user_model.dart';

class UserApp {
  final String id;
  final String email;
  final String name;

  UserApp({required this.id, required this.email, required this.name});

  UserApp map(UserModel userModel) {
    return UserApp(
      id: userModel.id,
      email: userModel.email,
      name: userModel.displayName,
    );
  }
}
