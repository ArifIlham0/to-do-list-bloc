import 'dart:convert';

String authRequestToJson(AuthRequest data) => json.encode(data.toJson());

class AuthRequest {
  final String? username;
  final String? password;
  final String? passwordConfirm;

  AuthRequest({
    this.username,
    this.password,
    this.passwordConfirm,
  });

  Map<String, dynamic> toJson() => {
        "username": username,
        "password": password,
        "password_confirm": passwordConfirm,
      };
}
