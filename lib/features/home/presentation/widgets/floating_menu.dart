import 'package:flutter/material.dart';
import 'package:flutter_task_skillgenic/features/task/presentation/views/add_todo_screen.dart';


class ExpandableFAB extends StatefulWidget {
  final VoidCallback onFabClosed;

  const ExpandableFAB({super.key, required this.onFabClosed});

  @override
  State<ExpandableFAB> createState() => _ExpandableFABState();
}

class _ExpandableFABState extends State<ExpandableFAB> {
  bool isOpen = false;

  void _handleAddTodo(String category) async {
    await showAddTodoBottomSheet(context, category);
    setState(() => isOpen = false); // Close FAB
    widget.onFabClosed(); // Notify parent to refresh
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (isOpen) ...[
          _buildMenuButton("Setup Journal", () => _handleAddTodo('Journal')),
          _buildMenuButton("Setup Habit", () => _handleAddTodo('Habit')),
          _buildMenuButton("Add Note", () => _handleAddTodo('Note')),
          _buildMenuButton("Add Todo", () => _handleAddTodo('Todo')),
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
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(label),
      ),
    );
  }
}
