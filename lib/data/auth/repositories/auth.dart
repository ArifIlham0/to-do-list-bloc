import 'package:dartz/dartz.dart';
import 'package:todolist_bloc/common/helpers/user_preferences.dart';
import 'package:todolist_bloc/data/auth/models/request/authentication_request.dart';
import 'package:todolist_bloc/data/auth/models/response/authentication_response.dart';
import 'package:todolist_bloc/data/auth/sources/auth_api_service.dart';
import 'package:todolist_bloc/domain/auth/repositories/auth.dart';
import 'package:todolist_bloc/service_locator.dart';

class AuthRepositoryImpl extends AuthRepository {
  @override
  Future<Either> register(AuthenticationRequest request) async {
    var data = await sl<AuthApiService>().register(request);
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
  Future<Either> login(AuthenticationRequest request) async {
    var data = await sl<AuthApiService>().login(request);
    return data.fold(
      (error) {
        return Left(error);
      },
      (data) async {
        final loginData = AuthenticationResponse.fromJson(data);
        await StorageHelper().setString("token", loginData.data?.accessToken ?? "");
        await StorageHelper().setInt("id", loginData.data?.id ?? 0);
        await StorageHelper().setBool("is_superuser", loginData.data?.isSuperuser ?? false);
        await StorageHelper().setString("username", loginData.data?.username ?? "");

        return Right(data);
      },
    );
  }
}
