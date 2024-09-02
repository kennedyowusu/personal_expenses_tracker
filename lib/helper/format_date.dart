String formatDate(DateTime date) {
  final day = date.day;
  final month = getMonthName(date.month);
  final year = date.year;

  return '$day $month, $year';
}

String getMonthName(int monthNumber) {
  const months = [
    'Jan',
    'Feb',
    'March',
    'April',
    'May',
    'June',
    'July',
    'Aug',
    'Sept',
    'Oct',
    'Nov',
    'Dec'
  ];
  return months[monthNumber - 1];
}
