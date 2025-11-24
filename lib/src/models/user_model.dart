class User {
  final String uid;
  final String email;
  final String password;

  User({
    this.uid = "",
    required this.email,
    this.password = "password",
  });

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      "uid": uid,
    };
  }

  factory User.fromMap(Map<String, dynamic> data) {
    return User(
      uid: data['uid'] ?? "",
      email: data['email'] ?? '',
    );
  }
}
