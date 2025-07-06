import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_task_skillgenic/features/notifications/domain/models/notification_item.dart';
import 'package:flutter_task_skillgenic/features/notifications/notifications_provider.dart';
final notificationProvider =
    StateNotifierProvider<NotificationNotifier, List<NotificationItem>>(
        (ref) => NotificationNotifier());
