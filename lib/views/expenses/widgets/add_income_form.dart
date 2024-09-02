import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_expenses_tracker/widgets/custom_border_button.dart';
import 'package:personal_expenses_tracker/constants/colors.dart';
import 'package:personal_expenses_tracker/providers/income_provider.dart';
import 'package:personal_expenses_tracker/model/income_model.dart';
import 'package:uuid/uuid.dart';

class AddIncomeForm extends ConsumerWidget {
  AddIncomeForm({super.key});

  final TextEditingController titleController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final uuid = const Uuid();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16.0,
        right: 16.0,
        top: 16.0,
      ),
      child: Container(
        height: 270,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 8),
            Text(
              'Add Income'.toUpperCase(),
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Name of Revenue',
              ),
              controller: titleController,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter revenue name';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Enter Amount',
              ),
              controller: amountController,
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter amount';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            CustomExpenseTrackerBorderButton(
              onPressed: () {
                final String title = titleController.text;
                final double amount =
                    double.tryParse(amountController.text) ?? 0.0;

                if (title.isEmpty || amount <= 0) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please enter a valid title and amount'),
                    ),
                  );
                  return;
                }

                final income = Income(
                  id: uuid.v4(),
                  title: title,
                  amount: amount,
                  date: DateTime.now(),
                );

                ref.read(incomeProvider.notifier).addIncome(income);
                Navigator.of(context).pop();
              },
              text: 'Add Income',
              backgroundColor: Colors.white,
              borderColor: secondaryColor,
              textColor: secondaryColor,
            )
          ],
        ),
      ),
    );
  }
}
