import 'package:dartz/dartz.dart';
import 'package:todolist_bloc/core/usecase/usecase.dart';
import 'package:todolist_bloc/data/todo/models/request/to_do_request.dart';
import 'package:todolist_bloc/domain/export_domain.dart';
import 'package:todolist_bloc/service_locator.dart';

class UpdateTodoParams {
  final String id;
  final ToDoRequest request;

  UpdateTodoParams({required this.id, required this.request});
}

class UpdateTodoUseCase extends UseCase<Either, UpdateTodoParams> {
  @override
  Future<Either> call({UpdateTodoParams? params}) async {
    return await sl<TodoRepository>().updateTodo(params!.id, params.request);
  }
}
