import 'package:flutter/material.dart';

class AuthHeaderText extends StatelessWidget {
  const AuthHeaderText(
      {super.key, required this.headerText, required this.subHeaderText});

  final String headerText, subHeaderText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          headerText,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          subHeaderText,
          textAlign: TextAlign.start,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
