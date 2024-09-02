import 'package:flutter/material.dart';
import 'package:personal_expenses_tracker/constants/colors.dart';

class ExpenseTrackerCustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final double height;
  final double width;
  final Color backgroundColor;
  final TextStyle textStyle;
  final BorderRadiusGeometry borderRadius;
  final bool isLoading;

  const ExpenseTrackerCustomButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.height = 50.0,
    this.width = double.infinity,
    this.backgroundColor = primaryColor,
    this.textStyle = const TextStyle(
      color: Colors.white,
      fontSize: 16.0,
      fontWeight: FontWeight.bold,
    ),
    this.borderRadius = const BorderRadius.all(Radius.circular(8.0)),
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            )
          : ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: backgroundColor,
                shape: RoundedRectangleBorder(
                  borderRadius: borderRadius,
                ),
              ),
              onPressed: onPressed,
              child: Text(
                text,
                style: textStyle,
              ),
            ),
    );
  }
}
