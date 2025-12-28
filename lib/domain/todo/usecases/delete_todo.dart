import 'package:dartz/dartz.dart';
import 'package:todolist_bloc/core/usecase/usecase.dart';
import 'package:todolist_bloc/data/todo/models/request/global_request.dart';
import 'package:todolist_bloc/domain/export_domain.dart';
import 'package:todolist_bloc/service_locator.dart';

class DeleteTodoParams {
  final GlobalRequest ids;

  DeleteTodoParams({required this.ids});
}

class DeleteTodoUseCase extends UseCase<Either, DeleteTodoParams> {
  @override
  Future<Either> call({DeleteTodoParams? params}) async {
    return await sl<TodoRepository>().deleteTodo(params!.ids);
  }
}
