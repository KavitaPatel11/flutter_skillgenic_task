import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models/task.dart';
import '../../domain/repositories/task_repository.dart';


import 'package:flutter/foundation.dart'; // 👈 Required for ChangeNotifier



final taskRepositoryProvider = Provider<TaskRepository>((ref) => TaskRepository());

final taskViewModelProvider = ChangeNotifierProvider<TaskViewModel>((ref) {
  return TaskViewModel(ref);
});
final searchQueryProvider = StateProvider<String>((ref) => '');

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

    Future<void> updateStatus(String taskId, String newStatus) async {
    final repository = ref.read(taskRepositoryProvider);
    final task = tasks.firstWhere((task) => task.id == taskId, orElse: () => throw Exception('Task not found'));
    final updatedTask = task.copyWith(status: newStatus);
    await repository.addOrUpdateTask(updatedTask);
    fetchCached();
  }
}
