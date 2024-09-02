import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_expenses_tracker/model/expense_model.dart';

final expensesProvider =
    StateNotifierProvider<ExpensesNotifier, List<Expense>>((ref) {
  return ExpensesNotifier();
});

class ExpensesNotifier extends StateNotifier<List<Expense>> {
  ExpensesNotifier() : super([]);

  void addExpense(Expense expense) {
    state = [...state, expense];
  }

  void removeExpense(String id) {
    state = state.where((expense) => expense.id != id).toList();
  }
}
