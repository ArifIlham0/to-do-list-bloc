import 'package:dartz/dartz.dart';
import 'package:todolist_bloc/core/usecase/usecase.dart';
import 'package:todolist_bloc/data/todo/models/request/to_do_request.dart';
import 'package:todolist_bloc/domain/export_domain.dart';
import 'package:todolist_bloc/service_locator.dart';

class CreateTodoUseCase extends UseCase<Either, ToDoRequest> {
  @override
  Future<Either> call({ToDoRequest? params}) async {
    return await sl<TodoRepository>().createTodo(params ?? ToDoRequest());
  }
}
