import 'package:todolist_bloc/data/todo/models/response/todos_response.dart';
import 'package:todolist_bloc/domain/todo/entities/todo.dart';

class TodoMapper {
  static TodoEntity toEntity(TodosResponse todos) {
    return TodoEntity(
      id: todos.id,
      title: todos.title,
      description: todos.description,
      time: todos.time,
    );
  }
}
