import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:todolist_bloc/core/network/dio_client.dart';
import 'package:todolist_bloc/data/auth/models/request/authentication_request.dart';
import 'package:todolist_bloc/service_locator.dart';

abstract class AuthApiService {
  Future<Either> register(AuthenticationRequest request);
  Future<Either> login(AuthenticationRequest request);
}

class AuthApiServiceImpl extends AuthApiService {
  @override
  Future<Either> register(AuthenticationRequest request) async {
    try {
      var response = await sl<DioClient>().post(
        "/user/create",
        data: request.toJson(),
      );

      return Right(response.data);
    } on DioException catch (e) {
      return Left(e.response?.data['message']);
    }
  }

  @override
  Future<Either> login(AuthenticationRequest request) async {
    try {
      var response = await sl<DioClient>().post(
        "/authentication/login",
        data: request.toJson(),
      );

      return Right(response.data);
    } on DioException catch (e) {
      return Left(e.response?.data['message']);
    }
  }
}
