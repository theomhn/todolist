import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/presentation/providers/create_todo_provider.dart';
import 'package:todolist/presentation/providers/user_profider.dart';
import 'package:todolist/presentation/screens/login.dart';
import 'package:todolist/theme_color.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page de profil'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Container(
            width: 1000,
            height: 400,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.2),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Icon(Icons.account_circle, size: 100),
                Text(
                  context.watch<UserProvider>().currentUser!.username,
                  style: const TextStyle(
                      fontSize: 30, fontWeight: FontWeight.bold),
                ),
                Text(context.watch<UserProvider>().currentUser!.email),
                Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(children: [
                          Text(
                              context
                                  .watch<CreateTodoProvider>()
                                  .todoList
                                  .length
                                  .toString(),
                              style: const TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold)),
                          const Text('Nombre de todo'),
                        ]),
                        Column(children: [
                          Text(
                              context
                                  .watch<CreateTodoProvider>()
                                  .todoList
                                  .where((todo) => todo.isDone)
                                  .length
                                  .toString(),
                              style: const TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold)),
                          const Text('Nombre de todo complété'),
                        ]),
                      ],
                    )),
                Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: ElevatedButton(
                        onPressed: () {
                          context.read<UserProvider>().logoutUser();
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()),
                              (route) => false);
                        },
                        child: Text(
                          'Deconnexion',
                          style: TextStyle(color: themeColor['red']),
                        )))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
