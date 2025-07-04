import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models/task.dart';
import '../../domain/repositories/task_repository.dart';


import 'package:flutter/foundation.dart'; // 👈 Required for ChangeNotifier



final taskRepositoryProvider = Provider<TaskRepository>((ref) => TaskRepository());

final taskViewModelProvider = ChangeNotifierProvider<TaskViewModel>((ref) {
  return TaskViewModel(ref);
});

class TaskViewModel extends ChangeNotifier {
  final Ref ref;

  TaskViewModel(this.ref) {
    fetchCached();
  }

  List<Task> tasks = [];

  void fetchCached() {
    tasks = ref.read(taskRepositoryProvider).getCachedTasks(); // ✅ use ref.read
    notifyListeners();
  }

  Future<void> addTask(Task task) async {
    await ref.read(taskRepositoryProvider).addOrUpdateTask(task);
    fetchCached();
  }

  Future<void> syncCloud() async {
    await ref.read(taskRepositoryProvider).syncWithCloud();
    fetchCached();
  }
}
