class AuthModel {
  final String email;
  final String password;

  AuthModel({required this.email, required this.password});

  Map<String, String> toJson() => {
        'email': email,
        'password': password,
      };
}
