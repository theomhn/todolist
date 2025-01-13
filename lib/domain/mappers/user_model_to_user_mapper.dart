import 'package:todolist/data/models/user_model.dart';
import 'package:todolist/domain/entities/user_app.dart';

class UserModelToUserMapper {
  UserApp map(UserModel userModel) {
    return UserApp(
      id: userModel.id,
      email: userModel.email,
      name: userModel.name,
    );
  }
}
