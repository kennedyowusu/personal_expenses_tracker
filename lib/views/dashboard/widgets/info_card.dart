import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String text;
  final double value;

  const InfoCard({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.text,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.grey.shade100,
          width: 1,
        ),
      ),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 15,
                  backgroundColor: Colors.grey.shade100,
                  child: Icon(
                    icon,
                    color: iconColor,
                    size: 15,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  text,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              'GHS ${value.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
