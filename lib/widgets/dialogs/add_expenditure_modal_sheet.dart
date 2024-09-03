import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_expenses_tracker/constants/colors.dart';
import 'package:personal_expenses_tracker/providers/expenditure_provider.dart';
import 'package:personal_expenses_tracker/widgets/custom_button.dart';
import 'package:personal_expenses_tracker/widgets/dialogs/add_category_modal_sheet.dart';

void showAddExpenditureSheet({
  required BuildContext context,
  required WidgetRef ref,
}) {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  Future<void> getExpenditures() async {
    final (_, err) = await ref.read(expendituresProvider).getExpenditures();
    if (err != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(err.message),
        ),
      );
    }
  }

  Future<void> addExpenditure({
    required String category,
    required String nameOfRevenue,
    required num estimatedAmount,
  }) async {
    if (nameOfRevenue.isEmpty || category.isEmpty || estimatedAmount <= 0) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid title and amount'),
        ),
      );
      return;
    }

    final (res, err) = await ref.read(expendituresProvider).addExpenditure(
          category: category,
          estimatedAmount: estimatedAmount,
          nameOfItem: nameOfRevenue,
        );

    if (res?.statusCode == 201) {
      Navigator.pop(context);
      getExpenditures();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("New expenditure added successfully"),
        ),
      );
    }

    if (err != null) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(err.message),
        ),
      );
    }
  }

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    barrierColor: Colors.black.withOpacity(0.5),
    enableDrag: true,
    isDismissible: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(20),
      ),
    ),
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 16.0,
          right: 16.0,
          top: 16.0,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 8),
            const Text(
              'ADD EXPENDITURE',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Amount Paid',
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
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
                side: const BorderSide(color: Colors.grey),
              ),
              color: Colors.white,
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: primaryColor.withOpacity(0.2),
                  child: const Icon(
                    Icons.category,
                    color: primaryColor,
                  ),
                ),
                title: Text(
                  categoryController.text.isEmpty
                      ? 'Select Category'
                      : categoryController.text,
                  style: TextStyle(
                    color: categoryController.text.isEmpty
                        ? Colors.grey
                        : Colors.black,
                  ),
                ),
                trailing: const Icon(Icons.arrow_drop_down),
                onTap: () {
                  showCategorySelectionSheet(context, categoryController);
                },
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Enter Item Name',
              ),
              keyboardType: TextInputType.text,
              controller: nameController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter name of item';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            Consumer(
              builder: (context, watchRef, child) {
                return PrimaryButton(
                  text: 'Save Expenditure',
                  isLoading: watchRef.watch(expendituresProvider).isLoading,
                  isOutlined: true,
                  labelColor: secondaryColor,
                  backgroundColor: Colors.white,
                  onPressed: () {
                    final category = categoryController.text;
                    final nameOfRevenue = nameController.text;
                    final estimatedAmount =
                        num.tryParse(amountController.text) ?? 0;

                    addExpenditure(
                      category: category,
                      nameOfRevenue: nameOfRevenue,
                      estimatedAmount: estimatedAmount,
                    );
                  },
                );
              },
            ),
            const SizedBox(height: 32),
          ],
        ),
      );
    },
  );
}
