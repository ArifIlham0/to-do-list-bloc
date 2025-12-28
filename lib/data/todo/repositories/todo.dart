import 'package:dartz/dartz.dart';
import 'package:todolist_bloc/data/export_data.dart';
import 'package:todolist_bloc/data/todo/models/request/global_request.dart';
import 'package:todolist_bloc/data/todo/models/request/to_do_request.dart';
import 'package:todolist_bloc/data/todo/models/response/to_dos_response.dart';
import 'package:todolist_bloc/domain/todo/repositories/todo.dart';
import 'package:todolist_bloc/service_locator.dart';

class TodoRepositoryImpl extends TodoRepository {
  @override
  Future<Either> fetchTodos() async {
    var data = await sl<TodoApiService>().fetchTodos();
    return data.fold(
      (error) {
        return Left(error);
      },
      (data) {
        var toDoData = ToDosResponse.fromJson(data);
        var toDos = toDoData.data;

        return Right(toDos);
      },
    );
  }

  @override
  Future<Either> createTodo(ToDoRequest request) async {
    var data = await sl<TodoApiService>().createTodo(request);
    return data.fold(
      (error) {
        return Left(error);
      },
      (data) {
        return Right(data);
      },
    );
  }

  @override
  Future<Either> updateTodo(String id, ToDoRequest request) async {
    var data = await sl<TodoApiService>().updateTodo(id, request);
    return data.fold(
      (error) {
        return Left(error);
      },
      (data) {
        return Right(data);
      },
    );
  }

  @override
  Future<Either> deleteTodo(GlobalRequest ids) async {
    var data = await sl<TodoApiService>().deleteTodo(ids);
    return data.fold(
      (error) {
        return Left(error);
      },
      (data) {
        return Right(data);
      },
    );
  }

  @override
  Future<Either> fetchOverdue() async {
    var data = await sl<TodoApiService>().fetchOverdue();
    return data.fold(
      (error) {
        return Left(error);
      },
      (data) {
        var toDoData = ToDosResponse.fromJson(data);
        var toDos = toDoData.data;
        return Right(toDos);
      },
    );
  }

  @override
  Future<Either> fetchComplete() async {
    var data = await sl<TodoApiService>().fetchComplete();
    return data.fold(
      (error) {
        return Left(error);
      },
      (data) {
        var toDoData = ToDosResponse.fromJson(data);
        var toDos = toDoData.data;

        return Right(toDos);
      },
    );
  }
}
