import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_expenses_tracker/model/expenditure.dart';

final expendituresProvider = Provider<List<Expenditure>>((ref) {
  return [
    Expenditure(
      name: 'Groceries',
      category: 'Food',
      amount: 150.00,
      color: Colors.blue,
    ),
    Expenditure(
      name: 'Bus Ticket',
      category: 'Transport',
      amount: 20.00,
      color: Colors.red,
    ),
    Expenditure(
      name: 'Lunch',
      category: 'Food',
      amount: 15.00,
      color: Colors.green,
    ),
    Expenditure(
      name: 'Taxi',
      category: 'Transport',
      amount: 50.00,
      color: Colors.orange,
    ),
  ];
});
