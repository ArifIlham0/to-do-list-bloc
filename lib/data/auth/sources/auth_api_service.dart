import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:todolist_bloc/common/helpers/user_preferences.dart';
import 'package:todolist_bloc/core/constants/api.dart';
import 'package:todolist_bloc/core/network/dio_client.dart';
import 'package:todolist_bloc/data/auth/models/request/auth_request.dart';
import 'package:todolist_bloc/service_locator.dart';

abstract class AuthApiService {
  Future<Either> register(AuthRequest request);
  Future<Either> login(AuthRequest request);
  Future<Either> checkAuth();
}

class AuthApiServiceImpl extends AuthApiService {
  @override
  Future<Either> register(AuthRequest request) async {
    try {
      var response = await sl<DioClient>().post(
        "/auth/register",
        data: request.toJson(),
      );

      return Right(response.data);
    } on DioException catch (e) {
      return Left(e.response?.data['message']);
    }
  }

  @override
  Future<Either> login(AuthRequest request) async {
    try {
      var response = await sl<DioClient>().post(
        "/auth/login",
        data: request.toJson(),
      );

      return Right(response.data);
    } on DioException catch (e) {
      return Left(e.response?.data['message']);
    }
  }

  @override
  Future<Either> checkAuth() async {
    String? token = await UserPreferences().getToken();
    try {
      var response = await sl<DioClient>().get(
        "/users/me",
        options: Options(headers: headerWithToken(token ?? "")),
      );

      return Right(response.data);
    } on DioException catch (e) {
      return Left(e.response?.data['message']);
    }
  }
}
