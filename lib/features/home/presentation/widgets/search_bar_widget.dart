import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_task_skillgenic/features/home/home_provider.dart';
import 'package:flutter_task_skillgenic/features/task/presentation/viewmodels/task_viewmodel.dart';

class SearchBarWidget extends ConsumerWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextField(
      onChanged: (query) {
        ref.read(searchQueryProvider.notifier).state = query;
      },
      decoration: InputDecoration(
        hintText: "Search Task",
        prefixIcon: const Icon(Icons.search),
        contentPadding: const EdgeInsets.symmetric(vertical: 14),
        filled: true,
        fillColor: const Color(0xFFF5F5F5),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
