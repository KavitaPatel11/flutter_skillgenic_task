import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'presentation/viewmodels/home_viewmodel.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

final homeViewModelProvider = StateNotifierProvider<HomeViewModel, String>((ref) {
  return HomeViewModel();
});



final connectivityProvider = StreamProvider<ConnectivityResult>((ref) {
  return Connectivity()
      .onConnectivityChanged
      .map((list) => list.first); // ✅ fix here
});


final selectedCategoryProvider = StateProvider<String>((ref) => 'Todo');



