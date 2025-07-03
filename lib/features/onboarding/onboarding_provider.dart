import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'presentation/viewmodels/onboarding_viewmodel.dart';

final onboardingViewModelProvider = StateNotifierProvider<OnboardingViewModel, String>((ref) {
  return OnboardingViewModel();
});
