import 'package:personal_expenses_tracker/model/expenditure.dart';

Map<String, List<Expenditure>> groupExpendituresByCategory(
  List<Expenditure> expenditures,
) {
  final Map<String, List<Expenditure>> categoryMap = {};

  for (Expenditure expenditure in expenditures) {
    if (!categoryMap.containsKey(expenditure.category)) {
      categoryMap[expenditure.category] = [];
    }
    categoryMap[expenditure.category]!.add(expenditure);
  }

  return categoryMap;
}
