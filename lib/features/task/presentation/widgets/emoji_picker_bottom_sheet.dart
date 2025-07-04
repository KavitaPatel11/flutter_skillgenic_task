import 'package:flutter/material.dart';

class EmojiPickerBottomSheet extends StatelessWidget {
  const EmojiPickerBottomSheet({Key? key}) : super(key: key);

  final List<String> emojis = const ['💼', '📚', '🧠', '🛒', '📞', '📝', '🔔'];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      padding: const EdgeInsets.all(16),
      child: GridView.builder(
        itemCount: emojis.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 6,
        ),
        itemBuilder: (_, index) => GestureDetector(
          onTap: () => Navigator.pop(context, emojis[index]),
          child: Center(
            child: Text(
              emojis[index],
              style: const TextStyle(fontSize: 28),
            ),
          ),
        ),
      ),
    );
  }
}
