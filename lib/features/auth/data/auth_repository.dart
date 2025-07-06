import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_task_skillgenic/features/auth/domain/models/user_model.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<UserModel?> signUp(String email, String password) async {
    final creds = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return UserModel(uid: creds.user!.uid, email: email);
  }

  Future<UserModel?> login(String email, String password) async {
    final creds = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return UserModel(uid: creds.user!.uid, email: email);
  }

  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }

  Stream<UserModel?> get userChanges {
    return _firebaseAuth.authStateChanges().map((user) =>
      user != null ? UserModel(uid: user.uid, email: user.email ?? '') : null);
  }
  
}
