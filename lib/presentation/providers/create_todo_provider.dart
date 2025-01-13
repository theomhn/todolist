import 'package:flutter/material.dart';

import '../../domain/entities/todo.dart';

class CreateTodoProvider with ChangeNotifier {
  final List<Todo> _todoList = [];

  List<Todo> get todoList => _todoList;

  void add(Todo todo) {
    _todoList.add(todo);
    notifyListeners();
  }

  void remove(int index) {
    _todoList.removeAt(index);
    notifyListeners();
  }

  void toggle(int index) {
    _todoList[index].isDone = !_todoList[index].isDone;
    notifyListeners();
  }
}
