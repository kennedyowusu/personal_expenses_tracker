import 'package:flutter/material.dart';
import 'package:personal_expenses_tracker/common/custom_border_button.dart';
import 'package:personal_expenses_tracker/constants/colors.dart';

void showAddExpenditureSheet(
  BuildContext context,
  TextEditingController amountController,
  TextEditingController categoryController,
  TextEditingController nameController,
) {
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
            Text(
              'Add Expenditure'.toUpperCase(),
              style: const TextStyle(
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
                  _showCategorySelectionSheet(context, categoryController);
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
            CustomExpenseTrackerBorderButton(
              text: 'Save Expenditure',
              backgroundColor: Colors.white,
              borderColor: secondaryColor,
              textColor: secondaryColor,
              onPressed: () {
                // Add your logic for saving expenditure
              },
            ),
            const SizedBox(height: 32),
          ],
        ),
      );
    },
  );
}

void _showCategorySelectionSheet(
    BuildContext context, TextEditingController categoryController) {
  final List<String> categories = [
    'Food',
    'Transport',
    'Shopping',
    'Health',
    'Others',
  ];

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
      return Container(
        padding: const EdgeInsets.all(16.0),
        height: MediaQuery.of(context).size.height * 0.45,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Select Category'.toUpperCase(),
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            const Divider(),
            Expanded(
              child: ListView.separated(
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(categories[index]),
                    onTap: () {
                      categoryController.text = categories[index];
                      Navigator.of(context).pop();
                    },
                  );
                },
                separatorBuilder: (context, index) => const Divider(),
              ),
            ),
            CustomExpenseTrackerBorderButton(
              backgroundColor: Colors.white,
              borderColor: secondaryColor,
              textColor: secondaryColor,
              text: 'Add Category',
              onPressed: () {
                // Add your logic for adding a new category
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
      );
    },
  );
}
