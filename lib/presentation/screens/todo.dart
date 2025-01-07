// lib/presentation/screens/todo_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/entities/todo.dart';
import '../providers/create_todo_provider.dart';
import '../../theme_color.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final TextEditingController _todoController = TextEditingController();

  void _addTodo() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Ajouter une nouvelle Todo'),
          content: TextField(
            controller: _todoController,
            decoration: const InputDecoration(hintText: 'Entrer votre todo'),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Annuler'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Add'),
              onPressed: () {
                Provider.of<CreateTodoProvider>(context, listen: false).add(
                  Todo(
                    text: _todoController.text,
                  ),
                );
                _todoController.clear();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
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
          child: ListView.builder(
            itemCount: context.watch<CreateTodoProvider>().todoList.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Checkbox(
                  value: context
                      .watch<CreateTodoProvider>()
                      .todoList[index]
                      .isDone,
                  onChanged: (bool? value) {
                    context.read<CreateTodoProvider>().toggle(index);
                  },
                ),
                title: Text(
                  context.watch<CreateTodoProvider>().todoList[index].text,
                  style: TextStyle(
                    decoration: context
                            .watch<CreateTodoProvider>()
                            .todoList[index]
                            .isDone
                        ? TextDecoration.lineThrough
                        : null,
                  ),
                ),
                trailing: IconButton(
                  icon: Icon(Icons.delete, color: themeColor['red']),
                  onPressed: () {
                    context.read<CreateTodoProvider>().remove(index);
                  },
                ),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: themeColor['primary'],
        onPressed: _addTodo,
        tooltip: 'add todo',
        child: const Icon(Icons.add),
      ),
    );
  }
}
