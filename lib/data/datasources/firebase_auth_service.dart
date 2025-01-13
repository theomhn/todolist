import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<User?> signInWithEmailPassword(String email, String password) async {
    try {
      final UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } catch (e) {
      print('Error in FirebaseAuthService: $e');
      return null;
    }
  }

  Future<User?> getUserById(String id) async {
    try {
      // Get current user
      final currentUser = _firebaseAuth.currentUser;

      // If the current user has the requested ID, return it
      if (currentUser?.uid == id) {
        return currentUser;
      }

      // Otherwise, return null as Firebase doesn't provide a direct way to get other users
      return null;
    } catch (e) {
      print('Error getting user by ID: $e');
      return null;
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
