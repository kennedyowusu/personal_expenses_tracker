import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:personal_expenses_tracker/constants/colors.dart';
import 'package:personal_expenses_tracker/constants/images.dart';

class NoDataWidget extends StatelessWidget {
  const NoDataWidget({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'No data found',
            style: TextStyle(
              fontSize: 18,
              color: textColor,
            ),
          ),
          const SizedBox(height: 16),
          SvgPicture.asset(empty, height: 200, width: 200),
        ],
      ),
    );
  }
}
