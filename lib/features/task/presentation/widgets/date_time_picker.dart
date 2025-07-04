import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimePicker extends StatelessWidget {
  final void Function(DateTime) onDateSelected;
  final void Function(TimeOfDay) onTimeSelected;
  final DateTime? selectedDate;
  final TimeOfDay? selectedTime;

  const DateTimePicker({
    Key? key,
    required this.onDateSelected,
    required this.onTimeSelected,
    this.selectedDate,
    this.selectedTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dateLabel = selectedDate != null
        ? DateFormat.yMMMd().format(selectedDate!)
        : 'Select Date';

    final timeLabel = selectedTime != null
        ? selectedTime!.format(context)
        : 'Select Time';

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        OutlinedButton.icon(
          onPressed: () async {
            final pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2020),
              lastDate: DateTime(2100),
            );
            if (pickedDate != null) onDateSelected(pickedDate);
          },
          icon: const Icon(Icons.calendar_today),
          label: Text(dateLabel),
        ),
        OutlinedButton.icon(
          onPressed: () async {
            final pickedTime = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.now(),
            );
            if (pickedTime != null) onTimeSelected(pickedTime);
          },
          icon: const Icon(Icons.access_time),
          label: Text(timeLabel),
        ),
      ],
    );
  }
}
