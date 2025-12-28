import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'to_dos_response.g.dart';

ToDosResponse toDosResponseFromJson(String str) => ToDosResponse.fromJson(json.decode(str));

String toDosResponseToJson(ToDosResponse data) => json.encode(data.toJson());

@JsonSerializable()
class ToDosResponse {
  @JsonKey(name: "status")
  final int? status;
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "data")
  final List<DatumToDo>? data;

  ToDosResponse({
      this.status,
      this.message,
      this.data,
  });

  factory ToDosResponse.fromJson(Map<String, dynamic> json) => _$ToDosResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ToDosResponseToJson(this);
}

@JsonSerializable()
class DatumToDo {
  @JsonKey(name: "id")
  final int? id;
  @JsonKey(name: "custom_user")
  final CustomUser? customUser;
  @JsonKey(name: "title")
  final String? title;
  @JsonKey(name: "description")
  final String? description;
  @JsonKey(name: "is_completed")
  final bool? isCompleted;
  @JsonKey(name: "due_date")
  final String? dueDate;
  @JsonKey(name: "created_at")
  final String? createdAt;
  @JsonKey(name: "updated_at")
  final String? updatedAt;

  DatumToDo({
      this.id,
      this.customUser,
      this.title,
      this.description,
      this.isCompleted,
      this.dueDate,
      this.createdAt,
      this.updatedAt,
  });

  factory DatumToDo.fromJson(Map<String, dynamic> json) => _$DatumToDoFromJson(json);

  Map<String, dynamic> toJson() => _$DatumToDoToJson(this);
}

@JsonSerializable()
class CustomUser {
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

  CustomUser({
      this.id,
      this.username,
      this.email,
      this.firstName,
      this.lastName,
      this.isSuperuser,
      this.isActive,
      this.dateJoined,
  });

  factory CustomUser.fromJson(Map<String, dynamic> json) => _$CustomUserFromJson(json);

  Map<String, dynamic> toJson() => _$CustomUserToJson(this);
}
