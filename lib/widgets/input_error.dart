import 'package:flutter/material.dart';

class ErrorTextWidget extends StatelessWidget {
  const ErrorTextWidget({
    super.key,
    required this.errorText,
  });

  final String errorText;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: errorText.isNotEmpty,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.red[50],
          borderRadius: BorderRadius.circular(6),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 5,
          vertical: 5.5,
        ),
        margin: const EdgeInsets.only(
          top: 4,
        ),
        child: Row(
          children: [
            const Icon(
              Icons.error,
              color: Colors.red,
              size: 16,
            ),
            const SizedBox(
              width: 4,
            ),
            Expanded(
              child: Text(
                errorText.replaceAll('Exception: ', ''),
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
