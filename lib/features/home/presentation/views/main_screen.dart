import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_task_skillgenic/features/home/home_provider.dart';
import 'package:flutter_task_skillgenic/features/home/presentation/widgets/task_card.dart';
import 'package:flutter_task_skillgenic/features/notifications/domain/models/notification_item.dart';
import 'package:flutter_task_skillgenic/features/notifications/presentation/viewmodels/notifications_viewmodel.dart';
import 'package:flutter_task_skillgenic/features/task/domain/models/task.dart';
import 'package:flutter_task_skillgenic/features/task/presentation/viewmodels/task_viewmodel.dart';
import 'package:flutter_task_skillgenic/features/task/presentation/views/add_todo_screen.dart';
import 'package:flutter_task_skillgenic/features/task/task_provider.dart';

import '../widgets/floating_menu.dart';
import '../widgets/home_app_bar.dart';
import '../widgets/search_bar_widget.dart';
import '../widgets/task_category_filter.dart';

import '../widgets/empty_state_widget.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  void _handleEditTask(BuildContext context, Task task) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => AddTodoSheet(
        task.category,
        existingTask: task,
      ),
    );

    ref.invalidate(taskViewModelProvider);
  }

 void _handleDeleteTask(
  BuildContext context,
  WidgetRef ref,
  String taskId,
) async {
  final confirm = await showDialog<bool>(
    context: context,
    builder: (_) => AlertDialog(
      title: const Text('Delete Task?'),
      content: const Text('Are you sure you want to delete this task?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: const Text('Delete'),
        ),
      ],
    ),
  );

  if (confirm == true) {
    // Show loading dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Container(
        height: 80,
        width: 80,
        color: Colors.white,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );

    try {
      await ref.read(taskListProvider.notifier).deleteTask(taskId);
      ref.invalidate(taskViewModelProvider);

      // Close the loading dialog
      Navigator.of(context, rootNavigator: true).pop();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Task deleted successfully")),
      );
    } catch (e) {
      Navigator.of(context, rootNavigator: true).pop(); // Close loading
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to delete task: $e")),
      );
    }
  }
}


  @override
  Widget build(BuildContext context) {
   final date = DateTime.now();
  final taskViewModel = ref.watch(taskViewModelProvider);
  final selectedCategory = ref.watch(selectedCategoryProvider);
  final searchQuery = ref.watch(searchQueryProvider); // 👈 watch the search query

  final filteredTasks = taskViewModel.tasks
      .where((task) =>
          task.category == selectedCategory &&
          task.title.toLowerCase().contains(searchQuery.toLowerCase()))
      .toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: HomeAppBar(date: date),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SearchBarWidget(),
            const SizedBox(height: 16),
            const TaskCategoryFilter(),
            const SizedBox(height: 24),
            Expanded(
              child: filteredTasks.isEmpty
                  ? const EmptyStateWidget()
                  : ListView.builder(
                      itemCount: filteredTasks.length,
                      itemBuilder: (context, index) {
                        final task = filteredTasks[index];
                        return TaskCard(
                          title: task.title,
                          description: task.description,
                          priorityLabel: _getPriorityLabel(task.priority),
                          priorityColor: _getPriorityColor(task.priority),
                          priorityIcon: _getPriorityIcon(task.priority),
                          time: TimeOfDay.fromDateTime(task.dueDate)
                              .format(context),
                          date: _formatDate(task.dueDate),
                          emoji: task.emoji,
                          completed: true,
                          status: task.status,
                          onEdit: () => _handleEditTask(context, task),
                          onDelete: () =>
                              _handleDeleteTask(context, ref, task.id),
                          onStatusChanged: (newStatus) {
                            ref
                                .read(taskViewModelProvider.notifier)
                                .updateStatus(task.id, newStatus);
                            ref.read(notificationProvider.notifier).add(
                                  NotificationItem(
                                    title: "Task Updated",
                                    message: "${task.title} has been updated.",
                                    timestamp: DateTime.now(),
                                    type: 'reminder',
                                    id: task.id,
                                    emoji: '🔔',
                                  ),
                                );
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: ExpandableFAB(
        onFabClosed: () {
          ref.invalidate(taskViewModelProvider);
          setState(() {});
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

String _formatDate(DateTime date) {
  return '${_getWeekday(date.weekday)}, ${date.day} ${_monthString(date.month)} ${date.year}';
}

String _getWeekday(int weekday) {
  const weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  return weekdays[weekday - 1];
}

String _monthString(int month) {
  const months = [
    '',
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];
  return months[month];
}

String _getPriorityLabel(String priority) {
  switch (priority.toLowerCase()) {
    case 'high':
      return 'High Priority';
    case 'medium':
      return 'Medium Priority';
    case 'low':
      return 'Low Priority';
    default:
      return 'Priority';
  }
}

Color _getPriorityColor(String priority) {
  switch (priority.toLowerCase()) {
    case 'high':
      return Colors.red;
    case 'medium':
      return Colors.orange;
    case 'low':
      return Colors.green;
    default:
      return Colors.grey;
  }
}

IconData _getPriorityIcon(String priority) {
  switch (priority.toLowerCase()) {
    case 'high':
      return Icons.warning_amber_rounded;
    case 'medium':
      return Icons.hourglass_bottom;
    case 'low':
      return Icons.check_circle_outline;
    default:
      return Icons.priority_high;
  }
}


