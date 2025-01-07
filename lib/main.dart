import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/data/repositories/user_repository_impl.dart';
import 'package:todolist/domain/usecases/user.dart';
import 'package:todolist/presentation/providers/user_profider.dart';
import 'package:todolist/presentation/screens/login.dart';
import 'package:todolist/presentation/screens/todo.dart';

import './theme_color.dart';
import 'presentation/providers/create_todo_provider.dart';
import 'presentation/screens/user_profile.dart';

void main() async {
  final userRepository = UserRepositoryImpl();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => CreateTodoProvider()),
    ChangeNotifierProvider(
      create: (_) => UserProvider(
          getUser: GetUser(userRepository),
          loginUser: LoginUser(userRepository),
          logoutUser: LogoutUser(userRepository)),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: themeColor['primary'] as Color),
        useMaterial3: true,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginPage(),
        '/profile': (context) => const UserProfile(),
        '/todo': (context) => const TodoScreen(),
      },
    );
  }
}
