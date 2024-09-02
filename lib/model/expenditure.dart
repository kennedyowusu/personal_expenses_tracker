import 'package:flutter/material.dart';

class Expenditure {
  final String name;
  final String category;
  final double amount;
  final Color color;

  Expenditure({
    required this.name,
    required this.category,
    required this.amount,
    required this.color,
  });
}
