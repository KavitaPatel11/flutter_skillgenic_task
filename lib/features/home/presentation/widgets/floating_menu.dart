import 'package:flutter/material.dart';
import 'package:flutter_task_skillgenic/features/task/presentation/views/add_todo_screen.dart';
class ExpandableFAB extends StatefulWidget {
  const ExpandableFAB({super.key});

  @override
  State<ExpandableFAB> createState() => _ExpandableFABState();
}

class _ExpandableFABState extends State<ExpandableFAB> {
  bool isOpen = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (isOpen) ...[
          _buildMenuButton("Setup Journal", () {}),
          _buildMenuButton("Setup Habit", () {}),
          _buildMenuButton("Add List", () {}),
          _buildMenuButton("Add Note", () {}),
          _buildMenuButton("Add Todo", () => showAddTodoBottomSheet(context)),
          const SizedBox(height: 12),
        ],
        FloatingActionButton(
          backgroundColor: const Color(0xFFFF6C0A),
          onPressed: () => setState(() => isOpen = !isOpen),
          child: Icon(isOpen ? Icons.close : Icons.add, size: 30),
        ),
      ],
    );
  }

  Widget _buildMenuButton(String label, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.deepOrange,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        child: Text(label),
      ),
    );
  }
}
