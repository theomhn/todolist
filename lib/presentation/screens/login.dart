import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/presentation/providers/auth_provider.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  await authProvider.signIn(
                      _emailController.text, _passwordController.text);
                  if (authProvider.user != null) {
                    // ignore: use_build_context_synchronously
                    Navigator.pushReplacementNamed(context, "/home");
                  } else {
                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Login failed")));
                  }
                },
                child: const Text('Login'),
              ),
            ],
          )),
    );
  }
}
