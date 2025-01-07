import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/presentation/providers/user_profider.dart';
import 'package:todolist/presentation/screens/todo.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: usernameController,
                decoration: const InputDecoration(labelText: 'username'),
              ),
              TextField(
                controller: passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  await userProvider.login(
                      usernameController.text, passwordController.text);
                  if (userProvider.currentUser != null) {
                    Navigator.pushReplacement(
                        // ignore: use_build_context_synchronously
                        context,
                        MaterialPageRoute(
                            builder: (context) => const TodoScreen()));
                  }
                },
                child: const Text('Login'),
              ),
            ],
          )),
    );
  }
}
