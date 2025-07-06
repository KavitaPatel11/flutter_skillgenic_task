import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_task_skillgenic/features/notifications/domain/models/notification_item.dart';
import 'package:flutter_task_skillgenic/features/notifications/presentation/viewmodels/notifications_viewmodel.dart';
import 'package:flutter_task_skillgenic/features/task/domain/models/task.dart';
import 'package:flutter_task_skillgenic/features/task/presentation/viewmodels/task_viewmodel.dart';
import 'package:flutter_task_skillgenic/features/task/presentation/views/add_todo_screen.dart';
import 'package:flutter_task_skillgenic/features/task/task_provider.dart';
import 'package:intl/intl.dart';

import '../../../home/presentation/widgets/task_card.dart';

class CalendarScreen extends ConsumerStatefulWidget {
  const CalendarScreen({super.key});

  @override
  ConsumerState<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends ConsumerState<CalendarScreen> {
  late DateTime selectedDate;
  late List<DateTime> monthDates;

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now();
    monthDates = generateMonthDates(selectedDate);
  }

  List<DateTime> generateMonthDates(DateTime date) {
    final firstDay = DateTime(date.year, date.month, 1);
    final lastDay = DateTime(date.year, date.month + 1, 0);
    return List.generate(
      lastDay.day,
      (index) => DateTime(date.year, date.month, index + 1),
    );
  }

  void showYearMonthPickerDialog({
    required BuildContext context,
    required DateTime selectedDate,
    required Function(DateTime) onDateSelected,
  }) {
    int selectedYear = selectedDate.year;
    int selectedMonth = selectedDate.month;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Select Month & Year'),
          content: StatefulBuilder(
            builder: (context, setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DropdownButton<int>(
                    value: selectedYear,
                    items: List.generate(50, (index) {
                      int year = DateTime.now().year - 25 + index;
                      return DropdownMenuItem(
                        value: year,
                        child: Text(year.toString()),
                      );
                    }),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          selectedYear = value;
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: List.generate(12, (index) {
                      final month = DateTime(0, index + 1);
                      return ChoiceChip(
                        label: Text(DateFormat('MMM').format(month)),
                        selected: selectedMonth == index + 1,
                        onSelected: (_) {
                          setState(() {
                            selectedMonth = index + 1;
                          });
                          onDateSelected(DateTime(selectedYear, selectedMonth));
                          Navigator.of(context).pop();
                        },
                      );
                    }),
                  ),
                ],
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
          ],
        );
      },
    );
  }

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

    // 🔁 Invalidate after bottom sheet is closed
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
    final tasks = ref.watch(taskViewModelProvider).tasks;
    final filteredTasks = tasks.where((task) {
      return DateFormat('yyyy-MM-dd').format(task.dueDate) ==
          DateFormat('yyyy-MM-dd').format(selectedDate);
    }).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                showYearMonthPickerDialog(
                  context: context,
                  selectedDate: selectedDate,
                  onDateSelected: (newDate) {
                    setState(() {
                      selectedDate = newDate;
                      monthDates = generateMonthDates(newDate);
                    });
                  },
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    DateFormat('MMM yyyy').format(selectedDate),
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const Icon(Icons.arrow_drop_down),
                ],
              ),
            ),
            const SizedBox(height: 10),

            // Date selector
            SizedBox(
              height: 90,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                itemCount: monthDates.length,
                itemBuilder: (context, index) {
                  final date = monthDates[index];
                  final isSelected = DateFormat('yyyy-MM-dd').format(date) ==
                      DateFormat('yyyy-MM-dd').format(selectedDate);

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedDate = date;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: Container(
                        width: 60,
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.orange : Colors.grey[200],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              DateFormat('EEE').format(date),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color:
                                      isSelected ? Colors.white : Colors.black),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              DateFormat('d').format(date),
                              style: TextStyle(
                                  fontSize: 16,
                                  color:
                                      isSelected ? Colors.white : Colors.black),
                            ),
                            const SizedBox(height: 4),
                            if (tasks.any((task) =>
                                DateFormat('yyyy-MM-dd').format(task.dueDate) ==
                                DateFormat('yyyy-MM-dd').format(date)))
                              Container(
                                width: 6,
                                height: 6,
                                decoration: const BoxDecoration(
                                  color: Colors.redAccent,
                                  shape: BoxShape.circle,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                DateFormat('EEEE, d MMM yyyy').format(selectedDate),
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),

            Expanded(
              child: filteredTasks.isEmpty
                  ? const Center(child: Text("No tasks for this day."))
                  : ListView.builder(
                      itemCount: filteredTasks.length,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
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
                          completed: false,
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
    );
  }

  Color _priorityColor(String priority) {
    switch (priority.toLowerCase()) {
      case 'high':
        return Colors.red;
      case 'medium':
        return Colors.orange;
      case 'low':
        return Colors.teal;
      default:
        return Colors.grey;
    }
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
