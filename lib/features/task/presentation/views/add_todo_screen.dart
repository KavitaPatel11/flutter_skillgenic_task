import 'package:flutter/material.dart';

import 'package:flutter_task_skillgenic/features/task/presentation/widgets/task_preview_modal.dart';
import 'package:go_router/go_router.dart';

import '../widgets/date_time_picker.dart';
import '../widgets/priority_selector.dart';

void showAddTodoBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (_) => const AddTodoSheet(),
  );
}

class AddTodoSheet extends StatefulWidget {
  const AddTodoSheet({super.key});

  @override
  State<AddTodoSheet> createState() => _AddTodoSheetState();
}

class _AddTodoSheetState extends State<AddTodoSheet> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  String? selectedEmoji = '💼';
  String selectedPriority = 'High';
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

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
      mainAxisSize: MainAxisSize.min, // important to fit to content
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Center(
        //   child: GestureDetector(
        //     onTap: () => showEmojiPicker(context),
        //     child: Text(
        //       selectedEmoji ?? '😀',
        //       style: const TextStyle(fontSize: 40),
        //     ),
        //   ),
        // ),

        const SizedBox(height: 12),

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

        ElevatedButton(
          onPressed: () {
            context.pop();
            showTaskPreviewModal(
            context,
            title: _titleController.text,
            description: _descController.text,
            emoji: selectedEmoji!,
            date: selectedDate,
            time: selectedTime,
            priority: selectedPriority,
          );
          },
          child: const Text('Create Task'),
        ),
      ],
    ),
  );
}
}