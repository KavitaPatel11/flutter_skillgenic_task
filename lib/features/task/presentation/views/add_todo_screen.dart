import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_task_skillgenic/features/notifications/domain/models/notification_item.dart';
import 'package:flutter_task_skillgenic/features/notifications/notifications_provider.dart';
import 'package:flutter_task_skillgenic/features/notifications/presentation/viewmodels/notifications_viewmodel.dart';
import 'package:flutter_task_skillgenic/features/task/domain/models/task.dart';
import 'package:flutter_task_skillgenic/features/task/presentation/widgets/task_preview_modal.dart';
import 'package:flutter_task_skillgenic/features/task/task_provider.dart';
import '../widgets/date_time_picker.dart';
import '../widgets/priority_selector.dart';

Future<void> showAddTodoBottomSheet(
  BuildContext context,
  String category, {
  Task? existingTask,
}) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (_) => AddTodoSheet(category, existingTask: existingTask),
  );
}

class AddTodoSheet extends ConsumerStatefulWidget {
  final String category;
  final Task? existingTask;

  const AddTodoSheet(this.category, {this.existingTask, super.key});

  @override
  ConsumerState<AddTodoSheet> createState() => _AddTodoSheetState();
}

class _AddTodoSheetState extends ConsumerState<AddTodoSheet> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  String selectedPriority = 'High';
  String selectedEmoji = '💼';
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  @override
  void initState() {
    super.initState();
    final task = widget.existingTask;
    if (task != null) {
      _titleController.text = task.title;
      _descController.text = task.description;
      selectedPriority = task.priority;
      selectedEmoji = task.emoji;
      selectedDate = task.dueDate;

      if (task.dueTime != null && task.dueTime!.isNotEmpty) {
        selectedTime = _parseTime(task.dueTime!);
      }
    }
  }

  TimeOfDay _parseTime(String time) {
    try {
      final format = RegExp(r'(\d+):(\d+)\s?(AM|PM)', caseSensitive: false);
      final match = format.firstMatch(time.trim());

      if (match != null) {
        int hour = int.parse(match.group(1)!);
        int minute = int.parse(match.group(2)!);
        String period = match.group(3)!.toUpperCase();

        if (period == 'PM' && hour != 12) hour += 12;
        if (period == 'AM' && hour == 12) hour = 0;

        return TimeOfDay(hour: hour, minute: minute);
      }
    } catch (_) {}
    return TimeOfDay.now();
  }

  void _addOrUpdateTask() async {
    final title = _titleController.text.trim();
    final desc = _descController.text.trim();

    if (title.isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Task title cannot be empty')),
        );
      }
      return;
    }
    final now = DateTime.now();
    final date = selectedDate ?? now;
    final time = selectedTime ?? TimeOfDay(hour: now.hour, minute: now.minute);

    final combinedDateTime = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );

    final task = Task(
      id: widget.existingTask?.id ??
          DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      description: desc,
      emoji: selectedEmoji,
      priority: selectedPriority,
      createdAt: widget.existingTask?.createdAt ?? DateTime.now(),
      dueTime: selectedTime?.format(context) ?? '',
      dueDate: combinedDateTime, // ✅ Fixed: this now has both date + time
      category: widget.category,
      status:widget.existingTask!=null? widget.existingTask!.status:'Todo',
    );

    // Show task preview before saving
    showTaskPreviewModal(
      context,
      title: task.title,
      description: task.description,
      emoji: task.emoji,
      date: task.dueDate,
      time: selectedTime,
      priority: task.priority,
      onSave: () async {
        // Show loader
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => const Center(child: CircularProgressIndicator()),
        );

        // Add or update task
        await ref.read(taskListProvider.notifier).addOrUpdate(task);

        // Notification
        ref.read(notificationProvider.notifier).add(
              NotificationItem(
                title:
                    widget.existingTask == null ? "Reminder" : "Task Updated",
                message: widget.existingTask == null
                    ? "Task '${task.title}' is scheduled."
                    : "Task '${task.title}' has been updated.",
                timestamp: DateTime.now(),
                type: widget.existingTask == null ? 'reminder' : 'update',
                id: '',
                emoji: '🔔',
              ),
            );

        if (mounted) {
          Navigator.of(context).pop(); // close loader
          Navigator.of(context).pop(); // close bottom sheet
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        top: 16,
        left: 16,
        right: 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(labelText: 'Task Title'),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _descController,
            decoration: const InputDecoration(labelText: 'Task Description'),
            maxLines: 3,
          ),
          const SizedBox(height: 12),
          PrioritySelector(
            selectedPriority: selectedPriority,
            onPriorityChanged: (val) => setState(() => selectedPriority = val),
          ),
          const SizedBox(height: 12),
          DateTimePicker(
            onDateSelected: (date) => setState(() => selectedDate = date),
            onTimeSelected: (time) => setState(() => selectedTime = time),
            selectedDate: selectedDate,
            selectedTime: selectedTime,
          ),
          const SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed: _addOrUpdateTask,
              child: Text(
                  widget.existingTask == null ? 'Create Task' : 'Update Task'),
            ),
          ),
        ],
      ),
    );
  }
}
