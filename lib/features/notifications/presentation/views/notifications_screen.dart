import 'package:flutter/material.dart';


import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_task_skillgenic/features/notifications/domain/models/notification_item.dart';
import 'package:flutter_task_skillgenic/features/notifications/presentation/viewmodels/notifications_viewmodel.dart';


class NotificationsScreen extends ConsumerWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifications = ref.watch(notificationProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
       
        title: const Text(
          "Notifications",
        
        ),
        centerTitle: true,
        // actions: [
        //   if (notifications.isNotEmpty)
        //     IconButton(
        //       icon: const Icon(Icons.delete_forever, color: Colors.red),
        //       onPressed: () => ref.read(notificationProvider.notifier).clearAll(),
        //     ),
        // ],
      ),
      body: notifications.isEmpty
          ? const Center(child: Text("No notifications"))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final item = notifications[index];
                return NotificationCard(
                  item: item,
                  onDelete: () =>
                      ref.read(notificationProvider.notifier).remove(item),
                );
              },
            ),
    );
  }
}

class NotificationCard extends StatelessWidget {
  final NotificationItem item;
  final VoidCallback onDelete;

  const NotificationCard({
    super.key,
    required this.item,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(item.timestamp.toIso8601String()),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => onDelete(),
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        color: Colors.redAccent,
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.grey.shade300),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade100,
              blurRadius: 10,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: '${item.emoji} ',
                    style: const TextStyle(fontSize: 18),
                  ),
                  TextSpan(
                    text: item.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4),
            Text(
              item.message,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
