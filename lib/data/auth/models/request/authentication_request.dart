import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'authentication_request.g.dart';

AuthenticationRequest authenticationRequestFromJson(String str) => AuthenticationRequest.fromJson(json.decode(str));

String authenticationRequestToJson(AuthenticationRequest data) => json.encode(data.toJson());

@JsonSerializable()
class AuthenticationRequest {
  @JsonKey(name: "username")
  final String? username;
  @JsonKey(name: "email")
  final String? email;
  @JsonKey(name: "email_or_username")
  final String? emailOrUsername;
  @JsonKey(name: "password")
  final String? password;

  AuthenticationRequest({
      this.username,
      this.email,
      this.emailOrUsername,
      this.password,
  });

  factory AuthenticationRequest.fromJson(Map<String, dynamic> json) => _$AuthenticationRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AuthenticationRequestToJson(this);
}
