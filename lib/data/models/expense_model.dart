class ExpenseModel {
  int id;
  int userId;
  double amount;
  String description;
  String category;
  DateTime date;

  ExpenseModel({
    required this.id,
    required this.userId,
    required this.amount,
    required this.description,
    required this.category,
    required this.date,
  });

  ExpenseModel.fromMap(Map<String, dynamic> map)
      : id = map['id'] as int,
        userId = map['user_id'] as int,
        amount = map['amount'] as double,
        description = map['description'] as String,
        category = map['category'] as String,
        date = DateTime.parse(map['date'] as String);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': userId,
      'amount': amount,
      'description': description,
      'category': category,
      'date': date.toString(),
    };
  }
}
