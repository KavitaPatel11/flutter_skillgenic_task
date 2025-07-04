import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_task_skillgenic/core/constants/app_colors.dart';
import '../../notifications_provider.dart';

class NotificationsScreen extends ConsumerWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(notificationsViewModelProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
    
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {},
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: const [
          NotificationTile(
            icon: Icons.notifications_active,
            title: 'Reminder',
            message:
                'Your interview with Sarah starts in 30 minutes. Get ready!',
          ),
          NotificationTile(
            icon: Icons.schedule,
            title: 'Upcoming Task',
            message:
                "Don't forget to complete Alex Interview before the deadline.",
          ),
          NotificationTile(
            icon: Icons.check_circle,
            title: 'Task Completed',
            message: "Great job! You've checked off a task. Keep going!",
          ),
          NotificationTile(
            icon: Icons.warning_amber_rounded,
            title: 'Task Due',
            message:
                "Your task 'Submit Report' is due in 1 hour. Stay on track!",
          ),
        ],
      ),
   
    );
  }
}

class NotificationTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String message;

  const NotificationTile({
    super.key,
    required this.icon,
    required this.title,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: Icon(icon, color: AppColors.primary),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(message),
      ),
    );
  }
}
