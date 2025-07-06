import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_task_skillgenic/features/auth/data/auth_repository.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../domain/models/user_model.dart';

class AuthViewModel extends StateNotifier<AsyncValue<UserModel?>> {
  final AuthRepository _authRepository;

  AuthViewModel(this._authRepository) : super(const AsyncValue.data(null)) {
    _authRepository.userChanges.listen(
      (user) => state = AsyncValue.data(user),
    );
  }

  /// Email/Password Login
  Future<void> login(String email, String password) async {
    state = const AsyncValue.loading();
    try {
      final user = await _authRepository.login(email, password);
      state = AsyncValue.data(user);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  /// Email/Password Signup
  Future<UserCredential?> signUp(String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      final user = credential.user;
      if (user != null) {
        final userModel = UserModel.fromFirebase(user);
        state = AsyncValue.data(userModel);
        return credential;
      } else {
        state = const AsyncValue.data(null);
        return null;
      }
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      return null;
    }
  }

  Future<void> logout() async {
    try {
      await _authRepository.logout();

      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<UserModel?> signInWithGoogle() async {
    state = const AsyncValue.loading();
    try {
      final googleSignIn = GoogleSignIn.instance;
      final GoogleSignInAccount? googleUser = await googleSignIn.authenticate();

      if (googleUser == null) {
        state = const AsyncValue.data(null); // Login cancelled
        return null;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.idToken,
        idToken: googleAuth.idToken,
      );

      final userCred =
          await FirebaseAuth.instance.signInWithCredential(credential);
      final userModel = UserModel.fromFirebase(userCred.user!);
      state = AsyncValue.data(userModel);
      return userModel; // ✅ Return user
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      return null;
    }
  }

 
}
