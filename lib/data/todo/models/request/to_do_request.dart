import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'to_do_request.g.dart';

ToDoRequest toDoRequestFromJson(String str) => ToDoRequest.fromJson(json.decode(str));

String toDoRequestToJson(ToDoRequest data) => json.encode(data.toJson());

@JsonSerializable()
class ToDoRequest {
  @JsonKey(name: "title")
  final String? title;
  @JsonKey(name: "description")
  final String? description;
  @JsonKey(name: "is_completed")
  final bool? isCompleted;
  @JsonKey(name: "due_date")
  final DateTime? dueDate;

  ToDoRequest({
      this.title,
      this.description,
      this.isCompleted,
      this.dueDate,
  });

  factory ToDoRequest.fromJson(Map<String, dynamic> json) => _$ToDoRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ToDoRequestToJson(this);
}
