import 'package:flutter_riverpod/flutter_riverpod.dart';

class TaskViewModel extends StateNotifier<String> {
  TaskViewModel() : super('Initial state of Task');
}
