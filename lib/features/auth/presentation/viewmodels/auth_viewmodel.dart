import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthViewModel extends StateNotifier<String> {
  AuthViewModel() : super('Initial state of Auth');
}
