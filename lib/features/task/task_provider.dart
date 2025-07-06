// providers/task_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_task_skillgenic/features/task/domain/models/task.dart';
import 'package:flutter_task_skillgenic/features/task/domain/repositories/task_repository.dart';

final taskRepositoryProvider = Provider<TaskRepository>((ref) {
  return TaskRepository();
});

final taskListProvider = StateNotifierProvider<TaskNotifier, List<Task>>((ref) {
  final repo = ref.read(taskRepositoryProvider);
  return TaskNotifier(repo);
});

class TaskNotifier extends StateNotifier<List<Task>> {
  final TaskRepository _repo;

  TaskNotifier(this._repo) : super(_repo.getCachedTasks());

  Future<void> addOrUpdate(Task task) async {
    await _repo.addOrUpdateTask(task);
    state = [...state.where((t) => t.id != task.id), task];
  }

  Future<void> deleteTask(String id) async {
    await _repo.deleteTask(id);
    state = state.where((t) => t.id != id).toList();
  }

  Future<void> loadTasks() async {
    state = _repo.getCachedTasks();
  }

  Future<void> sync() async {
    await _repo.syncWithCloud();
  }
}


