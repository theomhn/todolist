import 'package:todolist/domain/entities/user_app.dart';

class UserModel {
  /* String id;
  String email;
  String username;
  final bool isLoggedIn;

  UserModel({
    required this.id,
    required this.email,
    required this.username,
    required this.isLoggedIn,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      username: json['username'],
      isLoggedIn: json['isLoggedIn'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'username': username,
      'isLoggedIn': isLoggedIn,
    };
  }

  User toDomain() {
    return User(
      id: id,
      email: email,
      username: username,
      isLoggedIn: isLoggedIn,
    );
  }

  static UserModel fromDomain(User user) {
    return UserModel(
      id: user.id,
      email: user.email,
      username: user.username,
      isLoggedIn: user.isLoggedIn,
    );
  } */

  final String id;
  final String email;
  final String displayName;

  UserModel({required this.id, required this.email, required this.displayName});

  UserModel map(UserApp firebaseUser) {
    return UserModel(
      id: firebaseUser.uid,
      email: firebaseUser.email,
      displayName: firebaseUser.displayName ?? '',
    );
  }
}
