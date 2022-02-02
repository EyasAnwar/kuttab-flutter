class Login {
  late String username;
  late String password;

  Login({required this.username, required this.password});

  Login.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
  }
}
