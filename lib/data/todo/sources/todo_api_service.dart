import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:todolist_bloc/common/helpers/user_preferences.dart';
import 'package:todolist_bloc/core/constants/api.dart';
import 'package:todolist_bloc/core/network/dio_client.dart';
import 'package:todolist_bloc/data/models/global_query_params.dart';
import 'package:todolist_bloc/data/todo/models/request/global_request.dart';
import 'package:todolist_bloc/data/todo/models/request/to_do_request.dart';
import 'package:todolist_bloc/service_locator.dart';

abstract class TodoApiService {
  Future<Either> fetchTodos();
  Future<Either> createTodo(ToDoRequest request);
  Future<Either> updateTodo(String id, ToDoRequest request);
  Future<Either> deleteTodo(GlobalRequest ids);
  Future<Either> fetchOverdue();
  Future<Either> fetchComplete();
}

class TodoApiServiceImpl extends TodoApiService {
  @override
  Future<Either> fetchTodos() async {
    String? token = await StorageHelper().getString("token");
    try {
      var response = await sl<DioClient>().get(
        "/to-do/fetch",
        options: Options(headers: headersWithToken(token ?? "")),
        queryParameters: GlobalQueryParams(page: 1, pageSize: 15, isCompleted: false).toJson(),
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
        "/to-do/create",
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
        "/to-do/update/$id",
        options: Options(headers: headersWithToken(token ?? "")),
        data: request.toJson(),
      );

      return Right(response.data);
    } on DioException catch (e) {
      return Left(e.response?.data['message']);
    }
  }

  @override
  Future<Either> deleteTodo(GlobalRequest ids) async {
    String? token = await StorageHelper().getString("token");
    try {
      var response = await sl<DioClient>().delete(
        "/to-do/delete",
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
        "/to-do/fetch",
        options: Options(headers: headersWithToken(token ?? "")),
        queryParameters: GlobalQueryParams(page: 1, pageSize: 15, isOverdue: true).toJson()
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
        "/to-do/fetch",
        options: Options(headers: headersWithToken(token ?? "")),
        queryParameters: GlobalQueryParams(page: 1, pageSize: 15, isCompleted: true).toJson()
      );

      return Right(response.data);
    } on DioException catch (e) {
      return Left(e.response?.data['message']);
    }
  }
}
