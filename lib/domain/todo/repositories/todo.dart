import 'package:dartz/dartz.dart';
import 'package:todolist_bloc/data/todo/models/request/global_request.dart';
import 'package:todolist_bloc/data/todo/models/request/to_do_request.dart';

abstract class TodoRepository {
  Future<Either> fetchTodos();
  Future<Either> createTodo(ToDoRequest request);
  Future<Either> updateTodo(String id, ToDoRequest request);
  Future<Either> deleteTodo(GlobalRequest ids);
  Future<Either> fetchOverdue();
  Future<Either> fetchComplete();
}
