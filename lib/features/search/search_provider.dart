import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'presentation/viewmodels/search_viewmodel.dart';

final searchViewModelProvider = StateNotifierProvider<SearchViewModel, String>((ref) {
  return SearchViewModel();
});
