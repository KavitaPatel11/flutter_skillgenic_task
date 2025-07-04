import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../calendar_provider.dart';

class CalendarScreen extends ConsumerWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(calendarViewModelProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendar'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Friday, April 18, 2024',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            EventCard(
              priority: 'High Priority',
              title: 'Interview with Alex',
              description:
                  'Plan questions, capture insights, and document key takeaways.',
              time: '10:30 AM',
              status: 'To-Do',
              color: Colors.red.shade100,
            ),
            EventCard(
              priority: 'Low Priority',
              title: 'Product Meeting',
              description: '',
              time: '08:30 AM',
              status: 'To-Do',
              color: Colors.green.shade100,
            ),
            EventCard(
              priority: 'Medium Priority',
              title: 'Marketing Documentation',
              description: '',
              time: '01:00 PM',
              status: 'Completed',
              color: Colors.orange.shade100,
            ),
          ],
        ),
      ),
    );
  }
}

class EventCard extends StatelessWidget {
  final String priority;
  final String title;
  final String description;
  final String time;
  final String status;
  final Color color;

  EventCard({
    required this.priority,
    required this.title,
    required this.description,
    required this.time,
    required this.status,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(priority, style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text(title, style: TextStyle(fontSize: 18)),
            if (description.isNotEmpty) ...[
              SizedBox(height: 8),
              Text(description),
            ],
            SizedBox(height: 8),
            Text('Time: $time'),
            Text('Status: $status'),
          ],
        ),
      ),
    );
  }
}
