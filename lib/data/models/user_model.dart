class UserModel {
  int id;
  String username;

  UserModel({required this.id, required this.username});

  Map<String, dynamic> toMap() {
    return {'id': id, 'username': username};
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(id: map['id'], username: map['username']);
  }
}
