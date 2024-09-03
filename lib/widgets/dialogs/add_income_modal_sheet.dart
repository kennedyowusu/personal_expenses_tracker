import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_expenses_tracker/constants/colors.dart';
import 'package:personal_expenses_tracker/providers/income_provider.dart';
import 'package:personal_expenses_tracker/widgets/custom_button.dart';

Future<void> showAddIncomeModalSheet({
  required BuildContext context,
  required WidgetRef ref,
}) {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  Future<void> getIncomes() async {
    final (_, err) = await ref.read(incomeProvider).getIncomes();
    if (err != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(err.message),
        ),
      );
    }
  }

  Future<void> addIncome({
    required String nameOfRevenue,
    required num amount,
  }) async {
    if (nameOfRevenue.isEmpty || amount <= 0) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid title and amount'),
        ),
      );
      return;
    }

    final (res, err) = await ref.read(incomeProvider).addIncome(
          nameOfRevenue: nameOfRevenue,
          amount: amount,
        );

    if (res?.statusCode == 201) {
      Navigator.pop(context);
      getIncomes();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("New income added successfully"),
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

  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    barrierColor: Colors.black.withOpacity(0.5),
    enableDrag: true,
    isDismissible: true,
    anchorPoint: const Offset(0.5, 0.5),
    useSafeArea: true,
    transitionAnimationController: AnimationController(
      vsync: Navigator.of(context),
      duration: const Duration(milliseconds: 300),
    ),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(20),
      ),
    ),
    builder: (context) {
      return Container(
        padding: const EdgeInsets.only(
          top: 16,
          left: 16,
          right: 16,
          bottom: 32,
        ),
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
            Consumer(
              builder: (context, watchRef, child) {
                return ExpenseTrackerCustomButton(
                  text: 'Add Income',
                  isLoading: watchRef.watch(incomeProvider).isLoading,
                  isOutlined: true,
                  labelColor: secondaryColor,
                  backgroundColor: Colors.white,
                  onPressed: () {
                    final nameOfRevenue = titleController.text;
                    final amount = num.tryParse(amountController.text) ?? 0;

                    addIncome(
                      nameOfRevenue: nameOfRevenue,
                      amount: amount,
                    );
                  },
                );
              },
            ),
          ],
        ),
      );
    },
  );
}
