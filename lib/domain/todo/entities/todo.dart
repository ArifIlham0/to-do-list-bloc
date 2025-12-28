class TodoEntity {
  int? id;
  String? title;
  String? description;
  DateTime? dueDate;
  bool? isCompleted;

  TodoEntity({
    this.id,
    this.title,
    this.description,
    this.dueDate,
    this.isCompleted,
  });
}
