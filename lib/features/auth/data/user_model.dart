class UserModel {
  final String id;
  final String phoneNumber;
  final DateTime createdAt;
  const UserModel(
      {required this.id, required this.phoneNumber, required this.createdAt});

  factory UserModel.fromMap(Map<String, dynamic> data) {
    return UserModel(
        id: data['id'],
        phoneNumber: data['phoneNumber'],
        createdAt: data['createdAt']);
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'phoneNumber': phoneNumber, 'createdAt': createdAt};
  }
}
