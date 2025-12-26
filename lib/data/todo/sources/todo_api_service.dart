import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:todolist_bloc/common/helpers/user_preferences.dart';
import 'package:todolist_bloc/core/constants/api.dart';
import 'package:todolist_bloc/core/network/dio_client.dart';
import 'package:todolist_bloc/data/todo/models/request/delete_to_do_request.dart';
import 'package:todolist_bloc/data/todo/models/request/to_do_request.dart';
import 'package:todolist_bloc/service_locator.dart';

abstract class TodoApiService {
  Future<Either> fetchTodos();
  Future<Either> createTodo(ToDoRequest request);
  Future<Either> updateTodo(String id, ToDoRequest request);
  Future<Either> deleteTodo(DeleteToDoRequest ids);
  Future<Either> fetchOverdue();
  Future<Either> fetchComplete();
}

class TodoApiServiceImpl extends TodoApiService {
  @override
  Future<Either> fetchTodos() async {
    String? token = await StorageHelper().getString("token");
    try {
      var response = await sl<DioClient>().get(
        "/todos",
        options: Options(headers: headersWithToken(token ?? "")),
      );

      return Right(response.data);
    } on DioException catch (e) {
      return Left(e.response?.data['message']);
    }
  }

  @override
  Future<Either> createTodo(ToDoRequest request) async {
    String? token = await StorageHelper().getString("token");
    try {
      var response = await sl<DioClient>().post(
        "/todos",
        options: Options(headers: headersWithToken(token ?? "")),
        data: request.toJson(),
      );

      return Right(response.data);
    } on DioException catch (e) {
      return Left(e.response?.data['message']);
    }
  }

  @override
  Future<Either> updateTodo(String id, ToDoRequest request) async {
    String? token = await StorageHelper().getString("token");
    try {
      var response = await sl<DioClient>().put(
        "/todos/$id",
        options: Options(headers: headersWithToken(token ?? "")),
        data: request.toJson(),
      );

      return Right(response.data);
    } on DioException catch (e) {
      return Left(e.response?.data['message']);
    }
  }

  @override
  Future<Either> deleteTodo(DeleteToDoRequest ids) async {
    String? token = await StorageHelper().getString("token");
    try {
      var response = await sl<DioClient>().delete(
        "/todos",
        options: Options(headers: headersWithToken(token ?? "")),
        data: ids.toJson(),
      );
      return Right(response);
    } on DioException catch (e) {
      return Left(e.response?.data['message']);
    }
  }

  @override
  Future<Either> fetchOverdue() async {
    String? token = await StorageHelper().getString("token");
    try {
      var response = await sl<DioClient>().get(
        "/todos/overdue",
        options: Options(headers: headersWithToken(token ?? "")),
      );

      return Right(response.data);
    } on DioException catch (e) {
      return Left(e.response?.data['message']);
    }
  }

  @override
  Future<Either> fetchComplete() async {
    String? token = await StorageHelper().getString("token");
    try {
      var response = await sl<DioClient>().get(
        "/todos/complete",
        options: Options(headers: headersWithToken(token ?? "")),
      );

      return Right(response.data);
    } on DioException catch (e) {
      return Left(e.response?.data['message']);
    }
  }
}
