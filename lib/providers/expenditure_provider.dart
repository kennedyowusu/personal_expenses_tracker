import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_expenses_tracker/repositories/expenditure_repo.dart';
import 'package:personal_expenses_tracker/repositories/models/api_response_model.dart';
import 'package:personal_expenses_tracker/repositories/models/expenditure_list_res.dart';

class ExpenditureChangeNotifier extends ChangeNotifier {
  final ExpenditureRepo repo;

  ExpenditureChangeNotifier({
    required this.repo,
  });

  bool isLoading = false;
  String isFetchingErrorMessage = '';
  List<Expenditure> expenditures = [];

  Future<(ApiSuccess<ExpenditureListRes>? res, ApiError? err)>
      getExpenditures() async {
    isLoading = true;
    isFetchingErrorMessage = '';
    notifyListeners();

    final (res, err) = await repo.getExpenditureList();

    isLoading = false;
    if (res?.data != null) {
      expenditures = res?.data.data ?? [];
    }

    if (err != null) {
      isFetchingErrorMessage = err.message;
    }
    notifyListeners();

    return (res, err);
  }

  Future<(ApiSuccess<void>? res, ApiError? err)> addExpenditure({
    required String nameOfItem,
    required String category,
    required num estimatedAmount,
  }) async {
    isLoading = true;
    notifyListeners();

    final (res, err) = await repo.addExpenditure(
      nameOfItem: nameOfItem,
      category: category,
      estimatedAmount: estimatedAmount,
    );

    isLoading = false;
    notifyListeners();

    return (res, err);
  }

  Future<(ApiSuccess<void>? res, ApiError? err)> deleteExpenditure({
    required String expenditureId,
  }) async {
    isLoading = true;
    notifyListeners();

    final (res, err) = await repo.deleteExpenditure(
      expenditureId: expenditureId,
    );

    isLoading = false;
    notifyListeners();

    return (res, err);
  }
}

final expendituresProvider =
    ChangeNotifierProvider<ExpenditureChangeNotifier>((ref) {
  return ExpenditureChangeNotifier(
    repo: ExpenditureRepo(),
  );
});
