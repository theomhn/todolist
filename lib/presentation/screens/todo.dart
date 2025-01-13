import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/domain/entities/todo.dart';
import 'package:todolist/presentation/providers/create_todo_provider.dart';

import '../../theme_color.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final TextEditingController _todoController = TextEditingController();

  @override
  void dispose() {
    _todoController.dispose();
    super.dispose();
  }

  void _addTodo() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Ajouter une nouvelle Todo'),
          content: TextField(
            controller: _todoController,
            decoration: const InputDecoration(hintText: 'Entrer votre todo'),
            onSubmitted: (_) => _submitTodo(context),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Annuler'),
              onPressed: () {
                _todoController.clear();
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Ajouter'),
              onPressed: () => _submitTodo(context),
            ),
          ],
        );
      },
    );
  }

  void _submitTodo(BuildContext context) {
    if (_todoController.text.trim().isNotEmpty) {
      final todo = Todo(
        text: _todoController.text.trim(),
      );

      context.read<CreateTodoProvider>().add(todo);

      _todoController.clear();
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeColor['primary'],
        title: const Text('Todo List'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.pushNamed(context, '/profile');
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          decoration: BoxDecoration(
            color: themeColor['grey'],
            borderRadius: BorderRadius.circular(15),
          ),
          height: 600,
          child: Consumer<CreateTodoProvider>(
            builder: (context, todoProvider, child) {
              final todos = todoProvider.todoList;

              if (todos.isEmpty) {
                return const Center(
                  child: Text(
                    'Aucune tâche pour le moment',
                    style: TextStyle(fontSize: 16),
                  ),
                );
              }

              return ListView.builder(
                itemCount: todos.length,
                itemBuilder: (context, index) {
                  final todo = todos[index];
                  return Card(
                    elevation: 2,
                    margin: const EdgeInsets.symmetric(
                      vertical: 4,
                      horizontal: 8,
                    ),
                    child: ListTile(
                      leading: Checkbox(
                        value: todo.isDone,
                        activeColor: themeColor['primary'],
                        onChanged: (bool? value) {
                          if (todo.id != null && value != null) {
                            todoProvider.toggle(todo.id!, value);
                          }
                        },
                      ),
                      title: Text(
                        todo.text,
                        style: TextStyle(
                          decoration:
                              todo.isDone ? TextDecoration.lineThrough : null,
                        ),
                      ),
                      trailing: IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: themeColor['red'],
                        ),
                        onPressed: () {
                          if (todo.id != null) {
                            todoProvider.remove(todo.id!);
                          }
                        },
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: themeColor['primary'],
        onPressed: _addTodo,
        tooltip: 'Ajouter une tâche',
        child: const Icon(Icons.add),
      ),
    );
  }
}
