import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_task_skillgenic/features/auth/data/auth_repository.dart';
import 'package:flutter_task_skillgenic/features/auth/domain/models/user_model.dart';
import 'presentation/viewmodels/auth_viewmodel.dart';


final authRepositoryProvider = Provider<AuthRepository>((ref) => AuthRepository());
final authViewModelProvider =
    StateNotifierProvider<AuthViewModel, AsyncValue<UserModel?>>((ref) {
  return AuthViewModel(ref.read(authRepositoryProvider));
});

/// ============================
/// UI: login_screen.dart
/// ============================
