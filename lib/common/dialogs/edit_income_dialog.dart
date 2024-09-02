import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_expenses_tracker/common/custom_border_button.dart';
import 'package:personal_expenses_tracker/common/custom_button.dart';
import 'package:personal_expenses_tracker/constants/colors.dart';
import 'package:personal_expenses_tracker/model/income_model.dart';
import 'package:personal_expenses_tracker/providers/income_provider.dart';

void showEditIncomeDialog(BuildContext context, Income income, WidgetRef ref) {
  final TextEditingController titleController =
      TextEditingController(text: income.title);
  final TextEditingController amountController =
      TextEditingController(text: income.amount.toString());

  showDialog(
    context: context,
    barrierLabel: 'Edit Income',
    barrierColor: Colors.black.withOpacity(0.5),
    barrierDismissible: true,
    useSafeArea: true,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        title: const Text('Edit Income'),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Update Title',
              ),
              controller: titleController,
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 8),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Update Amount',
              ),
              controller: amountController,
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          CustomExpenseTrackerBorderButton(
            text: 'Cancel Update',
            backgroundColor: Colors.white,
            textColor: primaryColor,
            borderColor: primaryColor,
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          const SizedBox(height: 10),
          ExpenseTrackerCustomButton(
            text: 'Update Income',
            onPressed: () {
              final Income updatedIncome = Income(
                id: income.id,
                title: titleController.text,
                amount: double.parse(amountController.text),
                date: income.date,
              );
              ref.read(incomeProvider.notifier).updateIncome(updatedIncome);
              Navigator.of(context).pop();
            },
            backgroundColor: primaryColor,
          ),
        ],
      );
    },
  );
}
