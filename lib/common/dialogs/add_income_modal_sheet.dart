import 'package:flutter/material.dart';
import 'package:personal_expenses_tracker/views/expenses/widgets/add_income_form.dart';

void showAddIncomeModalSheet(BuildContext context) {
  showModalBottomSheet(
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
      return AddIncomeForm();
    },
  );
}
