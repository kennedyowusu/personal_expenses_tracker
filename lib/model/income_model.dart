class Income {
  final String id;
  final String title;
  final double amount;
  final DateTime date;

  Income({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
  });

  // Convert Income object to JSON
  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'amount': amount,
        'date': date.toIso8601String(),
      };

  // Create an Income object from JSON
  factory Income.fromJson(Map<String, dynamic> json) {
    return Income(
      id: json['id'],
      title: json['title'],
      amount: json['amount'],
      date: DateTime.parse(json['date']),
    );
  }
}
