// ================= lib/models/task.dart =================
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

  @HiveField(6)
  final String? dueTime;

  @HiveField(7)
  final DateTime? createdAt;

  @HiveField(8)
  final String category;

  @HiveField(9)
  final String status;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.dueDate,
    required this.priority,
    required this.emoji,
    this.dueTime,
    this.createdAt,
    required this.category,
    required this.status,
  });

  Task copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? dueDate,
    String? priority,
    String? emoji,
    String? dueTime,
    DateTime? createdAt,
    String? category,
    String? status,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      dueDate: dueDate ?? this.dueDate,
      priority: priority ?? this.priority,
      emoji: emoji ?? this.emoji,
      dueTime: dueTime ?? this.dueTime,
      createdAt: createdAt ?? this.createdAt,
      category: category ?? this.category,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() => {
        'title': title,
        'description': description,
        'dueDate': dueDate.toIso8601String(),
        'priority': priority,
        'emoji': emoji,
        'dueTime': dueTime,
        'createdAt': createdAt?.toIso8601String(),
        'category': category,
        'status': status,
      };

  static Task fromMap(String id, Map<String, dynamic> map) => Task(
        id: id,
        title: map['title'],
        description: map['description'],
        dueDate: DateTime.parse(map['dueDate']),
        priority: map['priority'],
        emoji: map['emoji'],
        dueTime: map['dueTime'],
        createdAt: map['createdAt'] != null ? DateTime.parse(map['createdAt']) : null,
        category: map['category'] ?? 'To-Do',
        status: map['status'] ?? 'To-Do',
      );
}
