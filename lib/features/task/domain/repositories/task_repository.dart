import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive/hive.dart';
import '../../domain/models/task.dart';

class TaskRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Box<Task> _box = Hive.box<Task>('tasksBox');

  Future<void> addOrUpdateTask(Task task) async {
    _box.put(task.id, task);
    final uid = _auth.currentUser?.uid;
    if (uid != null) {
      await _db.collection('users').doc(uid).collection('tasks').doc(task.id).set(task.toMap());
    }
  }

  List<Task> getCachedTasks() => _box.values.toList();

  Future<void> syncWithCloud() async {
    final uid = _auth.currentUser?.uid;
    if (uid != null) {
      for (var task in _box.values) {
        await _db.collection('users').doc(uid).collection('tasks').doc(task.id).set(task.toMap());
      }
    }
  }
}