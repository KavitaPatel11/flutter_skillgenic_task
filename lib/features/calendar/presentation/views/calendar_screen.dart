import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../calendar_provider.dart';

class CalendarScreen extends ConsumerWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(calendarViewModelProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Calendar Screen')),
      body: Center(child: Text(state)),
    );
  }
}
