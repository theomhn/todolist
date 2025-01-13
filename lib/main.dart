import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/data/datasources/firebase_auth_service.dart';
import 'package:todolist/data/repositories/auth_repository_impl.dart';
import 'package:todolist/data/repositories/todo_repository_impl.dart';
import 'package:todolist/domain/mappers/firebase_to_user_model_mapper.dart';
import 'package:todolist/domain/mappers/user_model_to_user_mapper.dart';
import 'package:todolist/domain/usecases/user.dart';
import 'package:todolist/presentation/providers/auth_provider.dart';
import 'package:todolist/presentation/providers/create_todo_provider.dart';
import 'package:todolist/presentation/screens/login.dart';
import 'package:todolist/presentation/screens/todo.dart';
import 'package:todolist/presentation/screens/user_profile.dart';

import './theme_color.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final firebaseAuthService = FirebaseAuthService();
  final firebaseToUserModelMapper = FirebaseToUserModelMapper();
  final userModelToUserMapper = UserModelToUserMapper();

  final authRepository = AuthRepositoryImpl(
    firebaseAuthService,
    firebaseToUserModelMapper,
  );

  final signInWithEmail = SignInWithEmail(
    authRepository,
    userModelToUserMapper,
  );

  final todoRepository = TodoRepositoryImpl();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => CreateTodoProvider(todoRepository),
      ),
      ChangeNotifierProvider(
        create: (context) => AuthProvider(signInWithEmail),
      ),
    ],
    child: const MyApp(),
  ));
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
        '/login': (context) => LoginScreen(),
        '/profile': (context) => const UserProfile(),
        '/home': (context) => const TodoScreen(),
      },
    );
  }
}
