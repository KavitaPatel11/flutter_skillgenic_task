import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchViewModel extends StateNotifier<String> {
  SearchViewModel() : super('Initial state of Search');
}
