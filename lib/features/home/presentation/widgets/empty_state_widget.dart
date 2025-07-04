import 'package:flutter/material.dart';

class EmptyStateWidget extends StatelessWidget {
  const EmptyStateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/empty_state.png',
            height: 180,
          ),
          const SizedBox(height: 16),
          // const Text(
          //   "Hooray!!",
          //   style: TextStyle(
          //     fontSize: 22,
          //     fontWeight: FontWeight.bold,
          //     color: Color(0xFF2F3B77),
          //   ),
          // ),
          // const SizedBox(height: 8),
          // const Text(
          //   "You don’t have any pending task today",
          //   style: TextStyle(color: Colors.black54),
          // )
        ],
      ),
    );
  }
}
