class DataBaseUser {
  DataBaseUser({required this.id, required this.email});

  final String id;
  final String email;

  factory DataBaseUser.fromMap(Map<String, dynamic> map, String id) {
    return DataBaseUser(
      id: id,
      email: map['email'],
    );
  }
}
