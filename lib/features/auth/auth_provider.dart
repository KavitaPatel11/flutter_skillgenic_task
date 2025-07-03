import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'presentation/viewmodels/auth_viewmodel.dart';

final authViewModelProvider = StateNotifierProvider<AuthViewModel, String>((ref) {
  return AuthViewModel();
});
