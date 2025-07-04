import 'package:flutter/material.dart';

class TodoInputField extends StatelessWidget {
  final String hint;
  final int maxLines;
  const TodoInputField({super.key, required this.hint, this.maxLines = 1});

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey),
        border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
      ),
    );
  }
}

class EmojiPickerRow extends StatelessWidget {
  const EmojiPickerRow({super.key});

  @override
  Widget build(BuildContext context) {
    final emojis = ["😊", "🤑", "😇", "🥰", "🙌", "👋", "😭", "✌️"];
    return Wrap(
      spacing: 10,
      children: emojis.map((e) => Text(e, style: const TextStyle(fontSize: 24))).toList(),
    );
  }
}
