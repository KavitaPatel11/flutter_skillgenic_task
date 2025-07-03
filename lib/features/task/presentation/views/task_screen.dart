import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../task_provider.dart';

class TaskScreen extends ConsumerWidget {
  const TaskScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(taskViewModelProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Task Screen')),
      body: Center(child: Text(state)),
    );
  }
}
