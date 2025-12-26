import 'dart:convert';

String todoRequestToJson(ToDoRequest data) => json.encode(data.toJson());

class ToDoRequest {
  String? title;
  String? description;
  String? time;
  bool? completed;

  ToDoRequest({
    this.title,
    this.description,
    this.time,
    this.completed,
  });

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "time": time,
        "completed": completed,
      };
}
