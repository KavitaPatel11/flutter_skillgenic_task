import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void showTaskPreviewModal(
  BuildContext context, {
  required String title,
  required String description,
  required String emoji,
  DateTime? date,
  TimeOfDay? time,
  required String priority,
}) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        insetPadding: const EdgeInsets.symmetric(horizontal: 24),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  "Preview",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(height: 12),

              Row(
                children: [
                  const Icon(Icons.assignment_outlined, size: 24),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 8),
              Text(
                description,
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),

              const Divider(height: 30),

              // Priority Row
              Row(
                children: [
                  const Icon(Icons.flag_outlined),
                  const SizedBox(width: 12),
                  const Text("Priority"),
                  const Spacer(),
                  const Icon(Icons.warning_amber_rounded, color: Colors.orange),
                  const SizedBox(width: 4),
                  Text(priority, style: const TextStyle(fontWeight: FontWeight.w500)),
                ],
              ),
              const SizedBox(height: 12),

              // Due Date Row
              Row(
                children: [
                  const Icon(Icons.access_time_outlined),
                  const SizedBox(width: 12),
                  const Text("Due Date"),
                  const Spacer(),
                  Text(
                    date != null ? DateFormat('dd MMM yyyy').format(date) : 'No Date',
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Time Row
              Row(
                children: [
                  const Icon(Icons.schedule_outlined),
                  const SizedBox(width: 12),
                  const Text("Time"),
                  const Spacer(),
                  Text(
                    time != null ? time.format(context) : 'No Time',
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.orange,
                        side: const BorderSide(color: Colors.transparent),
                        backgroundColor: const Color(0xFFF5F5F5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: const Text("Back"),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // Save action
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Task Created")),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: const Text("Save"),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      );
    },
  );
}
