import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:personal_expenses_tracker/constants/colors.dart';

class AuthPromptText extends StatelessWidget {
  final String questionText;
  final String actionText;
  final VoidCallback onActionTap;

  const AuthPromptText({
    super.key,
    required this.questionText,
    required this.actionText,
    required this.onActionTap,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: questionText,
        style: const TextStyle(color: textColor),
        children: [
          TextSpan(
            text: actionText,
            style: const TextStyle(
              color: primaryColor,
              fontWeight: FontWeight.bold,
            ),
            recognizer: TapGestureRecognizer()..onTap = onActionTap,
          ),
        ],
      ),
    );
  }
}
