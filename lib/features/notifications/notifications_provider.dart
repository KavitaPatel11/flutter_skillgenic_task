import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_task_skillgenic/features/notifications/domain/models/notification_item.dart';
import 'package:hive/hive.dart';

class NotificationNotifier extends StateNotifier<List<NotificationItem>> {
  static const _boxName = 'notifications';

  NotificationNotifier() : super([]) {
    _loadNotifications();
  }

  Future<void> _loadNotifications() async {
    final box = await Hive.openBox<NotificationItem>(_boxName);
    state = box.values.toList().reversed.toList();
  }

  Future<void> add(NotificationItem item) async {
    final box = await Hive.openBox<NotificationItem>(_boxName);
    await box.put(item.id, item);
    state = [item, ...state];
  }

  Future<void> remove(NotificationItem item) async {
    final box = await Hive.openBox<NotificationItem>(_boxName);
    await box.delete(item.id);
    state = state.where((e) => e.id != item.id).toList();
  }

  Future<void> clearAll() async {
    final box = await Hive.openBox<NotificationItem>(_boxName);
    await box.clear();
    state = [];
  }
}


