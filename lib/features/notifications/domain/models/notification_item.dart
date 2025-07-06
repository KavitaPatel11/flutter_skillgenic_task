import 'package:hive/hive.dart';

part 'notification_item.g.dart';

@HiveType(typeId: 1)
class NotificationItem {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String message;

  @HiveField(3)
  final DateTime timestamp;

  @HiveField(4)
  final String type;

  @HiveField(5)
  final String emoji;

  NotificationItem({
    required this.id,
    required this.title,
    required this.message,
    required this.timestamp,
    required this.type,
    required this.emoji,
  });
}
