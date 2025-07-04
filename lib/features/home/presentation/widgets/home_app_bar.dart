import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeAppBar extends StatelessWidget {
  final DateTime date;
  const HomeAppBar({super.key, required this.date});

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat('EEE dd MMMM yyyy').format(date);

    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      automaticallyImplyLeading: false,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Today',
              style: TextStyle(
                fontSize: 24,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              )),
          Text(formattedDate,
              style: const TextStyle(fontSize: 14, color: Colors.grey)),
        ],
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.more_vert, color: Colors.black),
        )
      ],
    );
  }
}
