class BudgetModel {
  int id;
  String username;

  BudgetModel({required this.id, required this.username});

  Map<String, dynamic> toMap() {
    return {'id': id, 'username': username};
  }

  factory BudgetModel.fromMap(Map<String, dynamic> map) {
    return BudgetModel(id: map['id'], username: map['username']);
  }
}
