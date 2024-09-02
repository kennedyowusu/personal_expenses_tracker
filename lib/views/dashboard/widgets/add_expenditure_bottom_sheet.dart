import 'package:flutter/material.dart';
import 'package:personal_expenses_tracker/widgets/custom_border_button.dart';

class AddExpenditureBottomSheet extends StatelessWidget {
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  AddExpenditureBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Add Expenditure',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: categoryController,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
              labelText: 'Category',
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter category';
              }
              return null;
            },
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: nameController,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
              labelText: 'Name of Item',
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter name of item';
              }
              return null;
            },
          ),
          const SizedBox(height: 8),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Estimated Amount',
            ),
            keyboardType: TextInputType.number,
            controller: amountController,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter estimated amount';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          CustomExpenseTrackerBorderButton(
            text: 'Save Expenditure',
            backgroundColor: Colors.white,
            textColor: Colors.red,
            borderColor: Colors.red,
            onPressed: () {
              // Handle save expenditure
              final category = categoryController.text;
              final nameOfItem = nameController.text;
              final estimatedAmount =
                  double.tryParse(amountController.text) ?? 0.0;

              if (category.isNotEmpty &&
                  nameOfItem.isNotEmpty &&
                  estimatedAmount > 0) {
                // Perform your save operation here
                Navigator.of(context).pop();
              }
            },
          ),
          const SizedBox(height: 8),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
