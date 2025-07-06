import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_task_skillgenic/features/home/home_provider.dart';

class TaskCategoryFilter extends ConsumerWidget {
  const TaskCategoryFilter({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ['Todo', 'Habit', 'Journal', 'Note'];
    final selectedCategory = ref.watch(selectedCategoryProvider);

    return SizedBox(
      height: 38,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = selectedCategory == category;
    
          return GestureDetector(
            onTap: () => ref.read(selectedCategoryProvider.notifier).state = category,
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFFFF6C0A) : Colors.white,
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                category,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: isSelected ? Colors.white : Colors.black,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
