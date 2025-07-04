import 'package:flutter/material.dart';

class CountryPickerField extends StatelessWidget {
  const CountryPickerField({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Phone Number", style: TextStyle(fontWeight: FontWeight.w500)),
        const SizedBox(height: 6),
        TextFormField(
          keyboardType: TextInputType.phone,
          initialValue: "(+91) 85726-05920",
          decoration: InputDecoration(
            prefixIcon: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                SizedBox(width: 10),
                CircleAvatar(
                  radius: 10,
                  backgroundImage: NetworkImage(
                    'https://flagcdn.com/w40/in.png',
                  ),
                ),
                SizedBox(width: 8),
              ],
            ),
            border: const OutlineInputBorder(),
          ),
        ),
      ],
    );
  }
}
