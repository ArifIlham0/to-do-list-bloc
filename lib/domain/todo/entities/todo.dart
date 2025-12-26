class TodoEntity {
  int? id;
  String? title;
  String? description;
  DateTime? time;
  bool? completed;

  TodoEntity({
    this.id,
    this.title,
    this.description,
    this.time,
    this.completed,
  });
}
