import 'package:flutter/foundation.dart';
import 'package:todolist/domain/entities/todo.dart';
import 'package:todolist/domain/repositories/todo_repository.dart';

class CreateTodoProvider with ChangeNotifier {
  final TodoRepository _repository;
  List<Todo> _todoList = [];

  CreateTodoProvider(this._repository) {
    _loadTodos();
  }

  List<Todo> get todoList => _todoList;

  Future<void> _loadTodos() async {
    try {
      _todoList = await _repository.getTodos();
      notifyListeners();
    } catch (e) {
      print('Error loading todos: $e');
    }
  }

  Future<void> add(Todo todo) async {
    try {
      await _repository.addTodo(todo);
      await _loadTodos();
    } catch (e) {
      print('Error adding todo: $e');
    }
  }

  Future<void> remove(String id) async {
    try {
      await _repository.deleteTodo(id);
      await _loadTodos();
    } catch (e) {
      print('Error removing todo: $e');
    }
  }

  Future<void> toggle(String id, bool newValue) async {
    try {
      await _repository.toggleTodo(id, newValue);
      await _loadTodos();
    } catch (e) {
      print('Error toggling todo: $e');
    }
  }
}
