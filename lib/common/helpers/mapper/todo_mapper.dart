import 'package:todolist_bloc/data/todo/models/response/to_dos_response.dart';
import 'package:todolist_bloc/domain/todo/entities/todo.dart';

class TodoMapper {
  static TodoEntity toEntity(DatumToDo data) {
    return TodoEntity(
      id: data.id,
      title: data.title,
      description: data.description,
      dueDate: DateTime.parse(data.dueDate ?? ""),
    );
  }
}
