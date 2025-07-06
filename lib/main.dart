import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_task_skillgenic/features/notifications/data/notification_service.dart';
import 'package:flutter_task_skillgenic/features/notifications/domain/models/notification_item.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'app.dart';
import 'features/task/domain/models/task.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await NotificationService.initialize();

  final appDocDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocDir.path);
  Hive.registerAdapter(TaskAdapter());
  Hive.registerAdapter(NotificationItemAdapter()); 

  await Hive.openBox<Task>('tasksBox');
  runApp(const MyApp());
}
