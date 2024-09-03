import 'package:flutter/material.dart';
import 'package:personal_expenses_tracker/constants/colors.dart';

class ExpenseTrackerCustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final double height;
  final double width;
  final Color backgroundColor;
  final BorderRadiusGeometry borderRadius;
  final bool isLoading;
  final bool isOutlined;
  final Color labelColor;

  const ExpenseTrackerCustomButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.height = 50.0,
    this.width = double.infinity,
    this.backgroundColor = primaryColor,
    this.borderRadius = const BorderRadius.all(Radius.circular(8.0)),
    this.isLoading = false,
    this.isOutlined = false,
    this.labelColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: isLoading
          ? Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(labelColor),
              ),
            )
          : ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: backgroundColor,
                shape: RoundedRectangleBorder(
                  borderRadius: borderRadius,
                  side: isOutlined
                      ? BorderSide(
                          color: labelColor,
                          width: 1,
                        )
                      : BorderSide.none,
                ),
              ),
              onPressed: onPressed,
              child: Text(
                text,
                style: TextStyle(
                  color: labelColor,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
    );
  }
}
