import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todolist/domain/entities/todo.dart';
import 'package:todolist/domain/repositories/todo_repository.dart';

class TodoRepositoryImpl implements TodoRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<List<Todo>> getTodos() async {
    try {
      final userId = _auth.currentUser?.uid;
      print('Getting todos for user: $userId');

      if (userId == null) throw Exception('User not authenticated');

      final querySnapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('todos')
          .orderBy('createdAt', descending: true)
          .get();

      print('Found ${querySnapshot.docs.length} todos');

      return querySnapshot.docs.map((doc) {
        print('Todo data: ${doc.data()}');
        return Todo(
          id: doc.id,
          text: doc['text'],
          isDone: doc['isDone'],
        );
      }).toList();
    } catch (e) {
      print('Error getting todos: $e');
      rethrow;
    }
  }

  @override
  Future<void> addTodo(Todo todo) async {
    try {
      final userId = _auth.currentUser?.uid;
      print('Adding todo for user: $userId');

      if (userId == null) throw Exception('User not authenticated');

      await _firestore.collection('users').doc(userId).collection('todos').add({
        'text': todo.text,
        'isDone': todo.isDone,
        'createdAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Error adding todo: $e');
      rethrow;
    }
  }

  @override
  Future<void> deleteTodo(String id) async {
    try {
      final userId = _auth.currentUser?.uid;
      print('Deleting todo for user: $userId');

      if (userId == null) throw Exception('User not authenticated');

      await _firestore
          .collection('users')
          .doc(userId)
          .collection('todos')
          .doc(id)
          .delete();
    } catch (e) {
      print('Error deleting todo: $e');
      rethrow;
    }
  }

  @override
  Future<void> toggleTodo(String id, bool isDone) async {
    try {
      final userId = _auth.currentUser?.uid;
      print('Toggling todo $id to $isDone for user: $userId');

      if (userId == null) throw Exception('User not authenticated');

      await _firestore
          .collection('users')
          .doc(userId)
          .collection('todos')
          .doc(id)
          .update({'isDone': isDone});
    } catch (e) {
      print('Error toggling todo: $e');
      rethrow;
    }
  }
}
