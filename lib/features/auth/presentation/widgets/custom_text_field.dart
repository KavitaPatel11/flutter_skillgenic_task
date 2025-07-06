import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String hint;
  final bool obscure;
  final Widget? suffixIcon;
  final TextEditingController? controller;

  const CustomTextField({
    super.key,
    required this.label,
    required this.hint,
    this.obscure = false,
    this.suffixIcon,
    this.controller
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          obscureText: obscure,
          decoration: InputDecoration(
            isDense: true,
            hintText: hint,
            border: const OutlineInputBorder(),
            suffixIcon: suffixIcon,
          ),
        ),
      ],
    );
  }
}
