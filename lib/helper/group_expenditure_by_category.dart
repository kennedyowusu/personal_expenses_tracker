import 'package:personal_expenses_tracker/repositories/models/expenditure_list_res.dart';

Map<String, List<Expenditure>> groupExpendituresByCategory(
  List<Expenditure> expenditures,
) {
  final Map<String, List<Expenditure>> categoryMap = {};

  for (Expenditure expenditure in expenditures) {
    if (!categoryMap.containsKey(expenditure.category)) {
      categoryMap[expenditure.category ?? ""] = [];
    }
    categoryMap[expenditure.category]!.add(expenditure);
  }

  return categoryMap;
}
