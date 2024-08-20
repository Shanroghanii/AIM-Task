import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth;

  AuthRepository(this._firebaseAuth);

  // Method to get current user
  User? getCurrentUser() {
    return _firebaseAuth.currentUser;
  }

  // Method to sign in with email and password
  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      rethrow; // Handle exceptions appropriately
    }
  }

  // Method to sign up with email and password
  Future<User?> signUpWithEmailAndPassword(String email, String password) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      rethrow; // Handle exceptions appropriately
    }
  }

  // Method to sign out
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
