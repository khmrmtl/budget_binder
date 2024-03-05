class IncomeModel {
  int id;
  int userId;
  double amount;
  String source;
  String date;

  IncomeModel({
    required this.id,
    required this.userId,
    required this.amount,
    required this.source,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': userId,
      'amount': amount,
      'source': source,
      'date': date,
    };
  }
}
