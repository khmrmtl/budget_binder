class IncomeModel {
  int id;
  int userId;
  double amount;
  String source;
  DateTime date;

  IncomeModel({
    required this.id,
    required this.userId,
    required this.amount,
    required this.source,
    required this.date,
  });

  IncomeModel.fromMap(Map<String, dynamic> map)
      : id = map['id'] as int,
        userId = map['user_id'] as int,
        amount = map['amount'] as double,
        source = map['source'] as String,
        date = DateTime.parse(map['date']);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': userId,
      'amount': amount,
      'source': source,
      'date': date.toString(),
    };
  }
}
