class ExpenseModel {
  int id;
  int userId;
  double amount;
  String description;
  String category;
  String date;

  ExpenseModel({
    required this.id,
    required this.userId,
    required this.amount,
    required this.description,
    required this.category,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': userId,
      'amount': amount,
      'description': description,
      'category': category,
      'date': date,
    };
  }
}
