class TodosResponse {
  int? id;
  String? title;
  String? description;
  DateTime? time;

  TodosResponse({
    this.id,
    this.title,
    this.description,
    this.time,
  });

  factory TodosResponse.fromJson(Map<String, dynamic> json) => TodosResponse(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        time: json["time"] == null ? null : DateTime.parse(json["time"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "time": time?.toIso8601String(),
      };
}
