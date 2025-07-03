import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'presentation/viewmodels/home_viewmodel.dart';

final homeViewModelProvider = StateNotifierProvider<HomeViewModel, String>((ref) {
  return HomeViewModel();
});
