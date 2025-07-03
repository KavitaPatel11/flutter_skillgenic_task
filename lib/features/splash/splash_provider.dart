import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'presentation/viewmodels/splash_viewmodel.dart';

final splashViewModelProvider = StateNotifierProvider<SplashViewModel, String>((ref) {
  return SplashViewModel();
});
