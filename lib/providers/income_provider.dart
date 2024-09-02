import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_expenses_tracker/model/income_model.dart';

final incomeProvider =
    StateNotifierProvider<IncomeNotifier, List<Income>>((ref) {
  return IncomeNotifier();
});

class IncomeNotifier extends StateNotifier<List<Income>> {
  final String _incomeKey = 'user_income';

  IncomeNotifier() : super([]) {
    _loadIncome();
  }

  // Load income data from local storage
  void _loadIncome() {
    // final incomeData = _storage.read<List<dynamic>>(_incomeKey) ?? [];
    // state = incomeData
    //     .map((json) => Income.fromJson(Map<String, dynamic>.from(json)))
    //     .toList();
  }

  // Save income data to local storage
  void _saveIncome() {
    // final incomeData = state.map((income) => income.toJson()).toList();
    // _storage.write(_incomeKey, incomeData);
  }

  void addIncome(Income income) {
    state = [...state, income];
    _saveIncome();
  }

  void deleteIncome(Income income) {
    state = state.where((element) => element.id != income.id).toList();
    _saveIncome();
  }

  void updateIncome(Income updatedIncome) {
    state = state.map((income) {
      if (income.id == updatedIncome.id) {
        return updatedIncome;
      }
      return income;
    }).toList();
    _saveIncome();
  }

  void deleteAllIncomes() {
    state = [];
    _saveIncome();
  }

  double get totalIncome {
    return state.fold(
        0.0, (previousValue, element) => previousValue + element.amount);
  }
}
