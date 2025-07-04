import 'package:hive/hive.dart';
part 'task.g.dart';

@HiveType(typeId: 0)
class Task {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String description;
  @HiveField(3)
  final DateTime dueDate;
  @HiveField(4)
  final String priority;
  @HiveField(5)
  final String emoji;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.dueDate,
    required this.priority,
    required this.emoji,
  });

  Map<String, dynamic> toMap() => {
        'title': title,
        'description': description,
        'dueDate': dueDate.toIso8601String(),
        'priority': priority,
        'emoji': emoji,
      };

  static Task fromMap(String id, Map<String, dynamic> map) => Task(
        id: id,
        title: map['title'],
        description: map['description'],
        dueDate: DateTime.parse(map['dueDate']),
        priority: map['priority'],
        emoji: map['emoji'],
      );
}