import 'package:flutter/material.dart';

class TaskCard extends StatelessWidget {
  final String title;
  final String description;
  final String priorityLabel;
  final Color priorityColor;
  final IconData priorityIcon;
  final String time;
  final String date;
  final String emoji;
  final bool completed;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final String status;
  final void Function(String) onStatusChanged;

  const TaskCard({
    super.key,
    required this.title,
    required this.description,
    required this.priorityLabel,
    required this.priorityColor,
    required this.priorityIcon,
    required this.time,
    required this.date,
    required this.emoji,
    required this.completed,
    required this.onEdit,
    required this.onDelete,
    required this.status,
    required this.onStatusChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Priority Bar
          Container(
            decoration: BoxDecoration(
              color: priorityColor,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(16)),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.flag, color: Colors.white, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      priorityLabel,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(priorityIcon, color: Colors.white, size: 16),
                  ],
                ),
                PopupMenuButton<String>(
                  icon: const Icon(Icons.more_horiz, color: Colors.white),
                  onSelected: (value) {
                    if (value == 'edit') {
                      onEdit();
                    } else if (value == 'delete') {
                      onDelete();
                    }
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 'edit',
                      child: ListTile(
                        leading: Icon(Icons.edit),
                        title: Text('Edit'),
                      ),
                    ),
                    const PopupMenuItem(
                      value: 'delete',
                      child: ListTile(
                        leading: Icon(Icons.delete, color: Colors.red),
                        title: Text('Delete'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Task Content
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title + Status Dropdown
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      completed
                          ? Icons.radio_button_checked
                          : Icons.radio_button_unchecked,
                      color: priorityColor,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          if (description.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: Text(
                                description,
                                style: TextStyle(color: Colors.grey.shade600),
                              ),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: _getStatusColor(status),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: status,
                          isDense: true,
                          icon: const Icon(Icons.arrow_drop_down),
                          borderRadius: BorderRadius.circular(10),
                          items: ['Todo', 'In Progress', 'Completed']
                              .map((status) => DropdownMenuItem(
                                    value: status,
                                    child: Row(
                                      children: [
                                        Icon(Icons.circle,
                                            size: 10,
                                            color: status == 'Completed'
                                                ? Colors.green
                                                : status == 'In Progress'
                                                    ? Colors.orange
                                                    : Colors.blue),
                                        const SizedBox(width: 8),
                                        Text(status),
                                      ],
                                    ),
                                  ))
                              .toList(),
                          onChanged: (newStatus) {
                            if (newStatus != null) {
                              onStatusChanged(newStatus);
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                const Divider(height: 24),
                // Time & Date Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.access_time, size: 16),
                        const SizedBox(width: 4),
                        Text(time),
                      ],
                    ),
                    Text(date, style: const TextStyle(color: Colors.grey)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Completed':
        return Colors.green.shade100;
      case 'In Progress':
        return Colors.orange.shade100;
      case 'Todo':
      default:
        return Colors.blue.shade100;
    }
  }
}
