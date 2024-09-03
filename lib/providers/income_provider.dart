import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_expenses_tracker/repositories/income_repo.dart';
import 'package:personal_expenses_tracker/repositories/models/api_response_model.dart';
import 'package:personal_expenses_tracker/repositories/models/income_list_res.dart';

class IncomeChangeNotifier extends ChangeNotifier {
  final IncomeRepo repo;

  IncomeChangeNotifier({
    required this.repo,
  });

  bool isLoading = false;
  String isFetchingErrorMessage = '';
  List<Income> incomes = [];

  Future<(ApiSuccess<IncomeListRes>? res, ApiError? err)> getIncomes() async {
    isLoading = true;
    isFetchingErrorMessage = '';
    notifyListeners();

    final (res, err) = await repo.getIncomeList();

    isLoading = false;
    if (res?.data != null) {
      incomes = res?.data.data ?? [];
    }

    if (err != null) {
      isFetchingErrorMessage = err.message;
    }
    notifyListeners();

    return (res, err);
  }

  Future<(ApiSuccess<void>? res, ApiError? err)> addIncome({
    required String nameOfRevenue,
    required num amount,
  }) async {
    isLoading = true;
    notifyListeners();

    final (res, err) = await repo.addIncome(
      nameOfRevenue: nameOfRevenue,
      amount: amount,
    );

    isLoading = false;
    notifyListeners();

    return (res, err);
  }

  Future<(ApiSuccess<void>? res, ApiError? err)> deleteIncome({
    required String incomeId,
  }) async {
    isLoading = true;
    notifyListeners();

    final (res, err) = await repo.deleteIncome(
      incomeId: incomeId,
    );

    isLoading = false;
    notifyListeners();

    return (res, err);
  }
}

final incomeProvider = ChangeNotifierProvider<IncomeChangeNotifier>((ref) {
  return IncomeChangeNotifier(
    repo: IncomeRepo(),
  );
});
