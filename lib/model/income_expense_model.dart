class IncomeExpenseData {
  final String month;
  final double income;
  final double expenses;

  IncomeExpenseData({
    required this.month,
    required this.income,
    required this.expenses,
  });
}

final List<IncomeExpenseData> incomeExpenseData = [
  IncomeExpenseData(month: 'Jan', income: 5000, expenses: 3000),
  IncomeExpenseData(month: 'Feb', income: 4500, expenses: 3200),
  IncomeExpenseData(month: 'Mar', income: 5200, expenses: 2800),
  IncomeExpenseData(month: 'Apr', income: 4800, expenses: 3300),
  IncomeExpenseData(month: 'May', income: 5100, expenses: 3100),
];

String getDayName(int day) {
  switch (day) {
    case 1:
      return 'Mon';
    case 2:
      return 'Tue';
    case 3:
      return 'Wed';
    case 4:
      return 'Thu';
    case 5:
      return 'Fri';
    case 6:
      return 'Sat';
    case 7:
      return 'Sun';
    default:
      return '';
  }
}
