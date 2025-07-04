import 'package:flutter/material.dart';

class PrioritySelector extends StatelessWidget {
  final String selectedPriority;
  final Function(String) onPriorityChanged;

  const PrioritySelector({
    Key? key,
    required this.selectedPriority,
    required this.onPriorityChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final priorities = ['High', 'Medium', 'Low'];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: priorities.map((priority) {
        final isSelected = selectedPriority == priority;
        return ChoiceChip(
          label: Text(priority),
          selected: isSelected,
          onSelected: (_) => onPriorityChanged(priority),
          selectedColor: Colors.orange,
        );
      }).toList(),
    );
  }
}
