import 'dart:convert';

AuthResponse authResponseFromJson(String str) =>
    AuthResponse.fromJson(json.decode(str));

String authResponseToJson(AuthResponse data) => json.encode(data.toJson());

class AuthResponse {
  int? status;
  String? message;
  Data? data;

  AuthResponse({
    this.status,
    this.message,
    this.data,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) => AuthResponse(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  int? id;
  String? username;
  bool? isAdmin;
  String? token;

  Data({
    this.id,
    this.username,
    this.isAdmin,
    this.token,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        username: json["username"],
        isAdmin: json["is_admin"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "is_admin": isAdmin,
        "token": token,
      };
}
