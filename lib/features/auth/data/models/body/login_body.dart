class LoginBody {
  String username;
  String password;

  LoginBody({required this.username, required this.password});

  Map<String, dynamic> toJson() => {
        "username": username,
        "password": password,
      };
}
