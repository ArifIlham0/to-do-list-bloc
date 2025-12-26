import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'authentication_response.g.dart';

AuthenticationResponse authenticationResponseFromJson(String str) => AuthenticationResponse.fromJson(json.decode(str));

String authenticationResponseToJson(AuthenticationResponse data) => json.encode(data.toJson());

@JsonSerializable()
class AuthenticationResponse {
  @JsonKey(name: "status")
  final int? status;
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "data")
  final DataAuthentication? data;

  AuthenticationResponse({
      this.status,
      this.message,
      this.data,
  });

  factory AuthenticationResponse.fromJson(Map<String, dynamic> json) => _$AuthenticationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AuthenticationResponseToJson(this);
}

@JsonSerializable()
class DataAuthentication {
  @JsonKey(name: "id")
  final int? id;
  @JsonKey(name: "username")
  final String? username;
  @JsonKey(name: "email")
  final String? email;
  @JsonKey(name: "first_name")
  final String? firstName;
  @JsonKey(name: "last_name")
  final String? lastName;
  @JsonKey(name: "is_superuser")
  final bool? isSuperuser;
  @JsonKey(name: "is_active")
  final bool? isActive;
  @JsonKey(name: "date_joined")
  final String? dateJoined;
  @JsonKey(name: "access_token")
  final String? accessToken;
  @JsonKey(name: "refresh_token")
  final String? refreshToken;

  DataAuthentication({
      this.id,
      this.username,
      this.email,
      this.firstName,
      this.lastName,
      this.isSuperuser,
      this.isActive,
      this.dateJoined,
      this.accessToken,
      this.refreshToken,
  });

  factory DataAuthentication.fromJson(Map<String, dynamic> json) => _$DataAuthenticationFromJson(json);

  Map<String, dynamic> toJson() => _$DataAuthenticationToJson(this);
}
