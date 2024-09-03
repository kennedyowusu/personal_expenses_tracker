import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:personal_expenses_tracker/constants/colors.dart';
import 'package:personal_expenses_tracker/constants/images.dart';

class NoDataWidget extends StatelessWidget {
  const NoDataWidget({super.key, required this.title, required this.message});

  final String title, message;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(empty, height: 100, width: 100),
          const SizedBox(height: 32),
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              color: textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}
